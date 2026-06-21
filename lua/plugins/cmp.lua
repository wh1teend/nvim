return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		{
			"Exafunction/windsurf.nvim",
			cmd = "Codeium",
			config = function()
				require("configs.ai.codeium")
			end,
		},
		{
			"zbirenbaum/copilot.lua",
			cmd = "Copilot",
			event = "InsertEnter",
			config = function()
				require("configs.ai.copilot")
			end,
		},
		{
			"zbirenbaum/copilot-cmp",
			config = function()
				require("configs.ai.copilotcmp")
			end,
		},
		{
			"SergioRibera/cmp-dotenv",
		},
	},
	config = require("configs.cmp"),
}
