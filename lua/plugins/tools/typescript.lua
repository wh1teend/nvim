return {
	{
		"pmizio/typescript-tools.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {},
	},
	{
		"dmmulroy/ts-error-translator.nvim",
		opts = {},
	},
	{
		"yelog/i18n.nvim",
		dependencies = {
			"ibhagwan/fzf-lua",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("i18n").setup({
				locales = { "en", "zh" },
				sources = {
					"src/locales/{locales}.json",
				},
			})
		end,
	},
}
