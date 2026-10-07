return function(opts)
	local options = {
		opts = {
			enable_close = true,
			enable_rename = true,
			enable_close_on_slash = false,
		},
	}

	return opts and vim.tbl_deep_extend("force", opts, options) or options
end
