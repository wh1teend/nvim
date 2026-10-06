return function(opts)
	local options = {
		outline_window = {
			focus_on_open = false,
		},

		outline_items = {
			show_symbol_details = true,
			auto_set_cursor = true,
		},

		preview_window = {
			open_hover_on_preview = true,
		},
	}

	return opts and vim.tbl_deep_extend("force", opts, options) or options
end
