return {
	"nvim-tree/nvim-tree.lua",
	opts = function(_, opts)
		return require("configs.tree")(opts)
	end,
}
