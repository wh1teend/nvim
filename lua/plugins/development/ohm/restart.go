package daemon

import (
	"fmt"
	"sync"
)

// Admission, ownership accounting and restart use the same lock. A bridge that
// wins admission is counted before restart can decide; a later bridge is refused.
func (d *Daemon) handleAttach(msg AttachMsg) (string, error) {
	d.restartMu.Lock()
	defer d.restartMu.Unlock()
	if d.restarting {
		return "", fmt.Errorf("daemon is restarting")
	}
	if msg.Owner == "" || msg.Connection == "" {
		return "", fmt.Errorf("bridge has no session or connection identity")
	}
	key := ServerKey{RootDir: msg.RootDir, LanguageID: msg.LanguageID}
	if _, exists := d.registry.Get(key); !exists {
		delete(d.owners, key)
	}
	if _, exists := d.owners[key][msg.Connection]; exists {
		return "", fmt.Errorf("connection already attached")
	}
	path, err := d.attach(msg)
	if err != nil {
		return "", err
	}
	if d.owners == nil {
		d.owners = make(map[ServerKey]map[string]string)
	}
	if d.owners[key] == nil {
		d.owners[key] = make(map[string]string)
	}
	d.owners[key][msg.Connection] = msg.Owner
	return path, nil
}

func (d *Daemon) handleDetach(msg DetachMsg) {
	d.restartMu.Lock()
	defer d.restartMu.Unlock()
	key := ServerKey{RootDir: msg.RootDir, LanguageID: msg.LanguageID}
	owners := d.owners[key]
	if owner, exists := owners[msg.Connection]; !exists || owner != msg.Owner {
		return
	}
	delete(owners, msg.Connection)
	if len(owners) == 0 {
		delete(d.owners, key)
	}
	d.detach(msg)
}

func (d *Daemon) respawnServer(key ServerKey) {
	d.restartMu.Lock()
	defer d.restartMu.Unlock()
	if !d.restarting {
		d.respawn(key)
	}
}

func (d *Daemon) beginRestart(owner string) bool {
	d.restartMu.Lock()
	defer d.restartMu.Unlock()
	if owner == "" || d.restarting {
		return false
	}
	d.registry.mu.Lock()
	defer d.registry.mu.Unlock()
	for key, server := range d.registry.servers {
		owned := 0
		for _, bridgeOwner := range d.owners[key] {
			if bridgeOwner == owner {
				owned++
			}
		}
		if server.Refs > owned {
			return false
		}
	}
	d.restarting = true
	return true
}

func (d *Daemon) shutdownForRestart() {
	d.restartMu.Lock()
	defer d.restartMu.Unlock()
	d.registry.mu.Lock()
	defer d.registry.mu.Unlock()
	var closing sync.WaitGroup
	for _, server := range d.registry.servers {
		closing.Add(1)
		go func(server *LSPServer) {
			defer closing.Done()
			server.Close()
		}(server)
	}
	closing.Wait()
}
