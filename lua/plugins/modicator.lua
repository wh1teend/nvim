return {
	"mawkler/modicator.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.cursorline = true
	end,
	opts = require("configs.modicator"),
}
