return {
	"sontungexpt/stcursorword",
	event = "VeryLazy",
	opts = function(_, opts)
		return require("configs.ui.cursor_word")(opts)
	end,
}
