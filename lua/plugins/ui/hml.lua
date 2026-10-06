return {
	"mawkler/hml.nvim",
	event = "VeryLazy",
	opts = function(_, opts)
		return require("configs.ui.hml")(opts)
	end,
}
