return function(opts)
	local options = opts or {}
	local binary = options.binary or require("lazy.core.config").plugins.ohm.dir .. "/bin/ohm"
	local socket = options.socket or vim.fn.stdpath("data") .. "/ohm.sock"
	local daemon = require("ohm.client")
	local owner = vim.fn.tempname()

	local function start_daemon()
		local command = options.debug and { binary, "--debug", socket } or { binary, socket }
		assert(vim.fn.jobstart(command, { detach = true }) > 0, "Failed to start ohm daemon")
		assert(
			vim.wait(3000, function()
				return daemon.probe(socket)
			end, 20),
			"ohm daemon did not become ready"
		)
	end
	if not daemon.probe(socket) then
		start_daemon()
	end

	local rpc_start = vim.lsp.rpc.start
	require("ohm").setup(vim.tbl_extend("force", options, { binary = binary, socket = socket }))

	local launching
	local connections = {}
	local function detach(connection)
		if connection.command and not connection.detached then
			daemon.detach({
				root_dir = connection.root_dir,
				language_id = connection.language_id,
				owner = owner,
				connection = connection.token,
			})
			connection.detached = true
		end
	end

	vim.lsp.rpc.start = function(command, dispatchers, spawn_options)
		if launching and type(command) == "table" and #command > 0 then
			local resolved = vim.fn.exepath(command[1])
			launching.command = resolved ~= "" and resolved or command[1]
			launching.args = { unpack(command, 2) }
			launching.token = vim.fn.tempname()
			local bridge = {
				binary,
				"--client",
				"--socket",
				socket,
				"--root",
				launching.root_dir,
				"--lang",
				launching.language_id,
				"--",
				launching.command,
			}
			vim.list_extend(bridge, launching.args)
			command = bridge
			spawn_options = vim.tbl_extend("force", spawn_options or {}, {
				env = vim.tbl_extend("force", spawn_options and spawn_options.env or {}, {
					OHM_SESSION = owner,
					OHM_CONNECTION = launching.token,
				}),
			})
		end
		return rpc_start(command, dispatchers, spawn_options)
	end

	local start = vim.lsp.start
	vim.lsp.start = function(config, start_options)
		config = vim.tbl_extend("force", config, {})
		if not config.root_dir and start_options and start_options._root_markers then
			config.root_dir = vim.fs.root(start_options.bufnr or 0, start_options._root_markers)
		end
		local connection = { root_dir = config.root_dir or vim.fn.getcwd(), language_id = config.name }
		local callbacks = {}
		if type(config.on_exit) == "function" then
			callbacks[1] = config.on_exit
		else
			vim.list_extend(callbacks, config.on_exit or {})
		end
		callbacks[#callbacks + 1] = function(_, _, id)
			detach(connection)
			connections[id] = nil
		end
		config.on_exit = callbacks

		local previous = launching
		launching = connection
		local ok, id = pcall(start, config, start_options)
		launching = previous
		if not ok then
			error(id, 0)
		end
		if id and connection.command then
			connections[id] = connection
		end
		return id
	end

	vim.api.nvim_create_augroup("ohm", { clear = true })
	vim.api.nvim_create_user_command("OhmRestart", function()
		local names, seen, clients = {}, {}, {}
		for _, client in ipairs(vim.lsp.get_clients()) do
			if connections[client.id] then
				clients[#clients + 1] = client
				if not seen[client.name] and vim.lsp.is_enabled(client.name) then
					seen[client.name] = true
					names[#names + 1] = client.name
				end
			end
		end
		local channel = vim.fn.sockconnect("pipe", socket, { rpc = true })
		local expired = false
		local timer = vim.uv.new_timer()
		timer:start(
			3000,
			0,
			vim.schedule_wrap(function()
				expired = true
				vim.fn.chanclose(channel)
			end)
		)
		local ok, accepted = pcall(vim.fn.rpcrequest, channel, "restart", owner)
		timer:stop()
		timer:close()
		if not expired then
			vim.fn.chanclose(channel)
		end
		assert(
			ok and type(accepted) == "boolean",
			"Daemon lacks atomic restart RPC; rebuild ohm and stop the old daemon before retrying"
		)
		if not accepted then
			vim.notify("OhmRestart refused: other Neovim sessions have active LSP connections", vim.log.levels.WARN)
			return
		end
		for _, client in ipairs(clients) do
			client:stop(true)
		end
		assert(
			vim.wait(3000, function()
				return next(connections) == nil
			end, 20),
			"LSP clients did not stop before daemon restart"
		)
		daemon.disconnect()
		assert(
			vim.wait(10000, function()
				return not daemon.probe(socket)
			end, 20),
			"Old ohm daemon did not stop"
		)
		start_daemon()
		assert(daemon.connect(socket), "Cannot connect to restarted ohm daemon")
		vim.lsp.enable(names)
	end, { desc = "Restart shared ohm daemon and current session LSP clients", force = true })
end
