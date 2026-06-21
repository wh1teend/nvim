return {
	{
		"pmizio/typescript-tools.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = require("configs.tools.typescript"),
	},
	{
		"dmmulroy/ts-error-translator.nvim",
		opts = require("configs.tools.tserror"),
	},
	{
		"yelog/i18n.nvim",
		dependencies = {
			"ibhagwan/fzf-lua",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("configs.tools.i18n")
		end,
	},
}
