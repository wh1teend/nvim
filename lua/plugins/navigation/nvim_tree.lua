return {
	"nvim-tree/nvim-tree.lua",
	opts = function(_, opts)
		return require("configs.navigation.nvim_tree")(opts)
	end,
}
