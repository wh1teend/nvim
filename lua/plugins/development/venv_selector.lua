return {
	"linux-cultist/venv-selector.nvim",
	branch = "main",
	ft = "python",
	cmd = "VenvSelect",
	dependencies = {
		"neovim/nvim-lspconfig",
		{ "nvim-telescope/telescope.nvim", optional = true },
	},
	opts = function(_, opts)
		return require("configs.development.venv_selector")(opts)
	end,
}
