return {
	"ryan-WORK/ohm",
	lazy = false,
	priority = 1000,
	build = function(plugin)
		local directory = plugin.dir .. "/build"
		vim.fn.mkdir(directory, "p")
		vim.fn.mkdir(plugin.dir .. "/bin", "p")
		local function replace(source, before, after)
			local first, last = source:find(before, 1, true)
			assert(
				first and not source:find(before, last + 1, true),
				"ohm restart overlay no longer matches upstream: " .. before
			)
			return source:sub(1, first - 1) .. after .. source:sub(last + 1)
		end
		local path = plugin.dir .. "/daemon/daemon.go"
		local source = table.concat(vim.fn.readfile(path), "\n")
		source = replace(
			source,
			"type Daemon struct {",
			[[type Daemon struct {
	restartMu sync.Mutex
	restarting bool
	owners map[ServerKey]map[string]string]]
		)
		for _, name in ipairs({ "AttachMsg", "DetachMsg" }) do
			source = replace(
				source,
				"type " .. name .. " struct {",
				"type " .. name .. ' struct {\n\tOwner string `codec:"owner"`\n\tConnection string `codec:"connection"`'
			)
		end
		for _, name in ipairs({ "Attach", "Detach" }) do
			source =
				replace(source, "func (d *Daemon) handle" .. name .. "(", "func (d *Daemon) " .. name:lower() .. "(")
		end
		source = replace(source, "func (d *Daemon) respawnServer(", "func (d *Daemon) respawn(")
		source = replace(
			source,
			'\t\tcase "status":',
			[[		case "restart":
			var owner string
			accepted := len(msg.Params) == 1 && h.DecodeParam(&owner, msg.Params[0]) == nil && d.beginRestart(owner)
			h.WriteResponse(conn, msg.MsgID, accepted)
			if accepted {
				d.shutdownForRestart()
				os.Exit(0)
			}

		case "status":]]
		)
		vim.fn.writefile(vim.split(source, "\n", { plain = true }), directory .. "/daemon.go")
		local client_path = plugin.dir .. "/daemon/lsp_client.go"
		local client = table.concat(vim.fn.readfile(client_path), "\n")
		client = replace(
			client,
			'"root_dir":    root,',
			'"root_dir":    root,\n\t\t\t"owner": os.Getenv("OHM_SESSION"),\n\t\t\t"connection": os.Getenv("OHM_CONNECTION"),'
		)
		vim.fn.writefile(vim.split(client, "\n", { plain = true }), directory .. "/lsp_client.go")
		local helpers = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h") .. "/ohm/restart.go"
		local overlay = directory .. "/overlay.json"
		vim.fn.writefile({
			vim.json.encode({
				Replace = {
					[path] = directory .. "/daemon.go",
					[client_path] = directory .. "/lsp_client.go",
					[plugin.dir .. "/daemon/restart.go"] = helpers,
				},
			}),
		}, overlay)
		local result = vim.system({ "go", "build", "-overlay", overlay, "-o", "bin/ohm", "." }, { cwd = plugin.dir })
			:wait()
		assert(result.code == 0, result.stderr)
	end,
	opts = {},
	config = function(_, opts)
		return require("configs.development.ohm")(opts)
	end,
}
