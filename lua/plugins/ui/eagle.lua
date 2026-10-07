return {
	"soulis-1256/eagle.nvim",
	event = "VeryLazy",
	keys = {
		{ "<leader>le", "<cmd>EagleWin<CR>", desc = "Eagle Hover" },
	},
	opts = function(_, opts)
		return require("configs.ui.eagle")(opts)
	end,
}
