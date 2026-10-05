return function(opts)
	local options = {
		name = { ".venv", "venv", "env" },
	}

	return opts and vim.tbl_deep_extend("force", opts, options) or options
end
