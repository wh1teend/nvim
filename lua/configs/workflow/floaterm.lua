return function(opts)
	local options = {
		border = false,
		size_h = 60,
		size_w = 70,
	}

	return opts and vim.tbl_deep_extend("force", opts, options) or options
end
