return function(opts)
	local options = {
		show_on_start = true,
		cursor_line_only = true,
	}

	return opts and vim.tbl_deep_extend("force", opts, options) or options
end
