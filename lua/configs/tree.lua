return function(opts)
	local options = {
		filters = {
			dotfiles = false,

			custom = {
				".DS_Store",
				".git",
			},

			exclude = {
				".gitignore",
				".env",
			},
		},
	}

	return opts and vim.tbl_deep_extend("force", opts, options) or options
end
