return {
	"mawkler/modicator.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.cursorline = true
	end,
	opts = function(_, opts)
		return require("configs.modicator")(opts)
	end,
}
