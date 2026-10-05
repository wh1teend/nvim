return {
	"neovim/nvim-lspconfig",
	config = function(_, opts)
		return require("configs.lsp")(opts)
	end,
}
