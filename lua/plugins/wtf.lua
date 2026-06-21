return {
	"piersolenski/wtf.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-telescope/telescope.nvim",
		"folke/snacks.nvim",
	},
	cmd = { "Wtf", "WtfDiagnose", "WtfFix", "WtfSearch", "WtfPickProvider", "WtfGrepHistory" },
	keys = {
		{
			"<leader>wd",
			mode = { "n", "x" },
			function()
				require("wtf").diagnose()
			end,
			desc = "Debug diagnostic with AI",
		},
		{
			"<leader>wf",
			mode = { "n", "x" },
			function()
				require("wtf").fix()
			end,
			desc = "Fix diagnostic with AI",
		},
		{
			"<leader>ws",
			function()
				require("wtf").search()
			end,
			desc = "Search diagnostic with Google",
		},
		{
			"<leader>wp",
			function()
				require("wtf").pick_provider()
			end,
			desc = "Pick provider",
		},
		{
			"<leader>wh",
			function()
				require("wtf").history()
			end,
			desc = "Populate the quickfix list with previous chat history",
		},
		{
			"<leader>wg",
			function()
				require("wtf").grep_history()
			end,
			desc = "Grep previous chat history with Telescope",
		},
	},
	opts = require("configs.wtf"),
}
