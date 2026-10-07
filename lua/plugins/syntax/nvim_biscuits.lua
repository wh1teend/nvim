return {
	"code-biscuits/nvim-biscuits",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	event = "VeryLazy",
	opts = function(_, opts)
		return require("configs.syntax.nvim_biscuits")(opts)
	end,
}
