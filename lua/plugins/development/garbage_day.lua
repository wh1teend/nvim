return {
	"Zeioth/garbage-day.nvim",
	event = "VeryLazy",
	opts = {},
	config = function(_, opts)
		return require("configs.development.garbage_day")(opts)
	end,
}
