return function(opts)
	local resolve = require("project_root")()
	local go_markers = { "go.mod", "go.work", ".git" }

	local function project_root()
		return resolve(go_markers)
	end

	local function package_directory()
		return resolve()
	end

	local function adapter(callback, config)
		callback({
			type = "server",
			host = "127.0.0.1",
			port = "${port}",
			executable = {
				command = vim.fn.stdpath("data") .. "/mason/bin/dlv",
				args = { "dap", "--listen", "127.0.0.1:${port}" },
				cwd = config.dlvCwd,
			},
		})
	end

	local options = {
		adapter = adapter,
		configurations = {
			{
				type = "delve",
				request = "launch",
				name = "Debug package",
				mode = "debug",
				program = package_directory,
				cwd = project_root,
				dlvCwd = project_root,
			},
			{
				type = "delve",
				request = "launch",
				name = "Debug package tests",
				mode = "test",
				program = package_directory,
				cwd = project_root,
				dlvCwd = project_root,
			},
			{
				type = "delve",
				request = "attach",
				name = "Attach to process",
				mode = "local",
				processId = function(...)
					return require("dap.utils").pick_process(...)
				end,
				dlvCwd = project_root,
			},
		},
	}

	return opts and vim.tbl_deep_extend("force", opts, options) or options
end
