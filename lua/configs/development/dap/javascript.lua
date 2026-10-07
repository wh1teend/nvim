return function(opts)
	local resolve = require("project_root")()
	local node_markers = {
		"package.json",
		"tsconfig.json",
		"jsconfig.json",
		"deno.json",
		"deno.jsonc",
		".git",
	}
	local compiled_entries = {}
	local browser_urls = {}

	local function project_root()
		return resolve(node_markers)
	end

	local function node_source_map_files(root)
		return {
			root .. "/**/*.js",
			root .. "/**/*.mjs",
			root .. "/**/*.cjs",
			"!**/node_modules/**",
		}
	end

	local function node_source_map_locations(root)
		return {
			root .. "/**",
			"!**/node_modules/**",
		}
	end

	local adapter = {
		type = "server",
		host = "127.0.0.1",
		port = "${port}",
		executable = {
			command = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter",
			args = { "${port}", "127.0.0.1" },
		},
	}

	local node_configurations = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch JavaScript or compiled TypeScript",
			program = function()
				if vim.bo.filetype == "javascript" then
					return vim.api.nvim_buf_get_name(0)
				end
				local root = project_root()
				local program =
					vim.fn.input("Path to compiled JavaScript: ", compiled_entries[root] or root .. "/", "file")
				if program ~= "" then
					compiled_entries[root] = program
				end
				return program
			end,
			cwd = project_root,
			sourceMaps = true,
			pauseForSourceMap = true,
			outFiles = function()
				return node_source_map_files(project_root())
			end,
			resolveSourceMapLocations = function()
				return node_source_map_locations(project_root())
			end,
			skipFiles = { "<node_internals>/**" },
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach to process",
			processId = function(...)
				return require("dap.utils").pick_process(...)
			end,
			cwd = project_root,
			sourceMaps = true,
			pauseForSourceMap = true,
			outFiles = function()
				return node_source_map_files(project_root())
			end,
			resolveSourceMapLocations = function()
				return node_source_map_locations(project_root())
			end,
			skipFiles = { "<node_internals>/**" },
		},
	}

	local browser_configurations = {
		{
			type = "pwa-chrome",
			request = "launch",
			name = "Launch browser against development server",
			url = function()
				local root = project_root()
				local url = vim.fn.input("Development server URL: ", browser_urls[root] or "http://localhost:5173")
				if url ~= "" then
					browser_urls[root] = url
				end
				return url
			end,
			webRoot = project_root,
			sourceMaps = true,
			pauseForSourceMap = true,
			resolveSourceMapLocations = {
				"**",
				"!**/node_modules/**",
			},
			skipFiles = { "**/node_modules/**" },
		},
		{
			type = "pwa-chrome",
			request = "attach",
			name = "Attach to browser",
			port = 9222,
			webRoot = project_root,
			sourceMaps = true,
			pauseForSourceMap = true,
			resolveSourceMapLocations = {
				"**",
				"!**/node_modules/**",
			},
			skipFiles = { "**/node_modules/**" },
		},
	}

	local options = {
		node_adapter = adapter,
		browser_adapter = vim.deepcopy(adapter),
		configurations = {
			node_configurations[1],
			node_configurations[2],
			browser_configurations[1],
			browser_configurations[2],
		},
		browser_configurations = browser_configurations,
	}

	return opts and vim.tbl_deep_extend("force", opts, options) or options
end
