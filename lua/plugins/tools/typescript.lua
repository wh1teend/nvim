return {
	{
		"pmizio/typescript-tools.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = function(_, opts)
			return require("configs.tools.typescript")(opts)
		end,
	},
	{
		"dmmulroy/ts-error-translator.nvim",
		opts = function(_, opts)
			return require("configs.tools.tserror")(opts)
		end,
	},
	{
		"yelog/i18n.nvim",
		dependencies = {
			"ibhagwan/fzf-lua",
			"nvim-treesitter/nvim-treesitter",
		},
		main = "i18n",
		opts = function(_, opts)
			return require("configs.tools.i18n")(opts)
		end,
	},
}
