return {
	"m-demare/hlargs.nvim",
	event = "VeryLazy",
	opts = function(_, opts)
		return require("configs.syntax.hlargs")(opts)
	end,
}
