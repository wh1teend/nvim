return function(opts)
	local options = {
		auto = true,
	}

	return opts and vim.tbl_deep_extend("force", opts, options) or options
end
