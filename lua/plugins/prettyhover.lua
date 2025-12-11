return {
	"Fildo7525/pretty_hover",
	event = "LspAttach",
	keys = {
		{
			"K",
			function()
				require("pretty_hover").hover()
			end,
			desc = "Hover",
		},
	},
	opts = {},
}
