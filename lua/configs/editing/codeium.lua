return function(opts)
	local options = {
		enable_chat = false,
	}

	return opts and vim.tbl_deep_extend("force", opts, options) or options
end
