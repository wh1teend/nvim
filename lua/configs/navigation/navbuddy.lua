return function(opts)
	local options = {
		lsp = {
			auto_attach = true,
		},
	}

	return opts and vim.tbl_deep_extend("force", opts, options) or options
end
