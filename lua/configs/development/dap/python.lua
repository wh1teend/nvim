return function(opts)
	local resolve = require("project_root")()
	local python_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" }

	local function project_root()
		return resolve(python_markers)
	end

	local function selected_python()
		local ok, venv_selector = pcall(require, "venv-selector")
		if ok then
			local python = venv_selector.python()
			if python and vim.fn.filereadable(python) == 1 then
				return python
			end
		end

		local separator = package.config:sub(1, 1)
		local executable = separator == "\\" and "Scripts\\python.exe" or "bin/python"
		local venv = vim.env.VIRTUAL_ENV
		if venv and venv ~= "" then
			local python = venv .. separator .. executable
			if vim.fn.filereadable(python) == 1 then
				return python
			end
		end

		local root = project_root()
		for _, directory in ipairs(require("language").languages.python.venv) do
			local python = root .. separator .. directory .. separator .. executable
			if vim.fn.filereadable(python) == 1 then
				return python
			end
		end

		return vim.fn.exepath("python3") ~= "" and vim.fn.exepath("python3") or "python"
	end

	local options = {
		adapter = function(callback, config)
			if config.request == "attach" then
				callback({
					type = "server",
					host = config.connect.host,
					port = config.connect.port,
				})
				return
			end

			callback({
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/bin/debugpy-adapter",
				args = {},
			})
		end,
		configurations = {
			{
				type = "python",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				cwd = project_root,
				python = selected_python,
			},
			{
				type = "python",
				request = "attach",
				name = "Attach to debugpy",
				connect = {
					host = "127.0.0.1",
					port = 5678,
				},
				pathMappings = {
					{
						localRoot = project_root,
						remoteRoot = project_root,
					},
				},
			},
		},
	}

	return opts and vim.tbl_deep_extend("force", opts, options) or options
end
