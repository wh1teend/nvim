return {
	"neovim/nvim-lspconfig",
	dependencies = { "ryan-WORK/ohm", "hasansujon786/nvim-navbuddy" },
	config = function(_, opts)
		return require("configs.development.lsp")(opts)
	end,
}
