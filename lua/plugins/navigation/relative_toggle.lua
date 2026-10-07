return {
	"cpea2506/relative-toggle.nvim",
	event = { "BufEnter", "InsertEnter" },
	opts = function(_, opts)
		return require("configs.navigation.relative_toggle")(opts)
	end,
}
