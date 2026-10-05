return function(opts)
	local options = {
		excluded = {
			filetypes = {
				"TelescopePrompt",
				"NvimTree",
			},
			buftypes = {
				"nofile",
				"terminal",
				"prompt",
				"quickfix",
				"help",
			},
		},
	}

	return opts and vim.tbl_deep_extend("force", opts, options) or options
end
