return {
	"mawkler/hml.nvim",
	event = "VeryLazy",
	opts = function(_, opts)
		return require("configs.hml")(opts)
	end,
}
