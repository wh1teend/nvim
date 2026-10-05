return {
	"sontungexpt/stcursorword",
	event = "VeryLazy",
	opts = function(_, opts)
		return require("configs.stcursorword")(opts)
	end,
}
