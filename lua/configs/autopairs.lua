return function(opts)
	local options = {
		map_bs = false,
	}

	return opts and vim.tbl_deep_extend("force", opts, options) or options
end
