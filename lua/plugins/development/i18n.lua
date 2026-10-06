return {
	"yelog/i18n.nvim",
	ft = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "json", "jsonc" },
	dependencies = {
		"ibhagwan/fzf-lua",
		"nvim-treesitter/nvim-treesitter",
	},
	main = "i18n",
	opts = function(_, opts)
		return require("configs.development.i18n")(opts)
	end,
}
