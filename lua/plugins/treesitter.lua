return {
	"nvim-treesitter/nvim-treesitter",
	opts = function(_, opts)
		return require("configs.treesitter")(opts)
	end,
}
