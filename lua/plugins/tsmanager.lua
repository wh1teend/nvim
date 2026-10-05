return {
	"romus204/tree-sitter-manager.nvim",
	cmd = "TSManager",
	opts = function(_, opts)
		return require("configs.tsmanager")(opts)
	end,
}
