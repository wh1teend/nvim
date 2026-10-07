return function(opts)
	local options = {
		registries = {
			"lua:mason_lsp_packages",
			"github:mason-org/mason-registry",
		},
	}

	return opts and vim.tbl_deep_extend("force", opts, options) or options
end
