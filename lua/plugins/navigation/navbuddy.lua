return {
	"hasansujon786/nvim-navbuddy",
	main = "nvim-navbuddy",
	event = "LspAttach",
	cmd = "Navbuddy",
	keys = {
		{ "<leader>ln", "<cmd>Navbuddy<CR>", desc = "Navbuddy" },
	},
	dependencies = {
		"SmiteshP/nvim-navic",
		"MunifTanjim/nui.nvim",
	},
	opts = function(_, opts)
		return require("configs.navigation.navbuddy")(opts)
	end,
}
