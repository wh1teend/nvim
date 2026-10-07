return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	opts = function(_, opts)
		return require("configs.ui.trouble")(opts)
	end,
}
