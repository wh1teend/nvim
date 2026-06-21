return {
	"linux-cultist/venv-selector.nvim",
	branch = "regexp",
	ft = "python",
	cmd = { "VenvSelect", "VenvSelectCached", "VenvSelectCurrent" },
	dependencies = {
		"neovim/nvim-lspconfig",
		{ "nvim-telescope/telescope.nvim", optional = true },
		{ "mfussenegger/nvim-dap-python", optional = true },
	},
	opts = require("configs.tools.python"),
}
