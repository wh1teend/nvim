return {
	"mason-org/mason.nvim",
	opts = function(_, opts)
		return require("configs.development.mason")(opts)
	end,
	config = function(_, opts)
		package.preload["mason_lsp_packages"] = function()
			return { "mason_lsp_packages.typescript_plugin_css_modules" }
		end
		package.preload["mason_lsp_packages.typescript_plugin_css_modules"] = function()
			local _, definition = require("configs.development.lsp.typescript")()
			return definition
		end
		require("mason").setup(opts)
	end,
}
