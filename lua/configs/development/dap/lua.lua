return function(opts)
	local options = {
		adapter = function(callback, config)
			callback({
				type = "server",
				host = config.host or "127.0.0.1",
				port = config.port or 8086,
			})
		end,
		configurations = {
			{
				type = "nlua",
				request = "attach",
				name = "Attach to running Neovim instance",
				host = "127.0.0.1",
				port = 8086,
			},
		},
	}

	return opts and vim.tbl_deep_extend("force", opts, options) or options
end
