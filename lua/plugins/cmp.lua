return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		{
			"Exafunction/windsurf.nvim",
			cmd = "Codeium",
			main = "codeium",
			opts = function(_, opts)
				return require("configs.ai.codeium")(opts)
			end,
		},
		{
			"SergioRibera/cmp-dotenv",
		},
	},
	config = function(_, opts)
		return require("configs.cmp")(opts)
	end,
}
