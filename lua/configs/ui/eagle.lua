return function(opts)
	local options = {
		mouse_mode = true,
		keyboard_mode = true,
		improved_markdown = false,
	}

	return opts and vim.tbl_deep_extend("force", opts, options) or options
end
