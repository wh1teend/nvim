return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufNewFile" },
	config = function(_, opts)
		return require("configs.linter")(opts)
	end,
}
