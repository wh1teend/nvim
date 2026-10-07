return function(opts)
	local resolve = require("project_root")()
	local php_markers =
		{ "composer.json", "phpunit.xml", "phpstan.neon", "phpstan.neon.dist", "phpstan.dist.neon", ".git" }

	local function project_root()
		return resolve(php_markers)
	end

	local options = {
		adapter = {
			type = "executable",
			command = vim.fn.stdpath("data") .. "/mason/bin/php-debug-adapter",
			args = {},
		},
		configurations = {
			{
				type = "php",
				request = "launch",
				name = "Listen for Xdebug",
				port = 9003,
				pathMappings = {},
			},
			{
				type = "php",
				request = "launch",
				name = "Launch current script with Xdebug",
				program = "${file}",
				cwd = project_root,
				runtimeExecutable = "php",
				runtimeArgs = {
					"-dxdebug.mode=debug",
					"-dxdebug.start_with_request=yes",
					"-dxdebug.client_port=9003",
				},
				port = 9003,
			},
		},
	}

	return opts and vim.tbl_deep_extend("force", opts, options) or options
end
