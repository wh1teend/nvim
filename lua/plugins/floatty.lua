return {
	"ingur/floatty.nvim",
	keys = {
		{
			"<A-t>",
			function()
				require("configs.floatty").toggle()
			end,
			mode = { "n", "t" },
			desc = "Toggle floating terminal",
		},
	},
}
