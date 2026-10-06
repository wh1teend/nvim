return function(opts)
	local options = {
		highlight = "Comment",
		include_paren = true,
		anywhere_on_line = true,
		show_same_line_opening = false,

		excluded_buftypes = {
			"terminal",
		},
	}

	return opts and vim.tbl_deep_extend("force", opts, options) or options
end
