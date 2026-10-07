return {
	"nvim-treesitter/nvim-treesitter",
	opts = function(_, opts)
		return require("configs.syntax.treesitter")(opts)
	end,
}
