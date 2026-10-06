return {
	"neovim/nvim-lspconfig",
	config = function(_, opts)
		return require("configs.development.lsp")(opts)
	end,
}
