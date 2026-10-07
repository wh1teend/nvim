return function(opts)
	local options = {
		hl_priority = 200,
	}

	return opts and vim.tbl_deep_extend("force", opts, options) or options
end
