return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	opts = function(_, opts)
		return require("configs.trouble")(opts)
	end,
}
