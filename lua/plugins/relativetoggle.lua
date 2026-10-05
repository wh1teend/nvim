return {
	"cpea2506/relative-toggle.nvim",
	event = { "BufEnter", "InsertEnter" },
	opts = function(_, opts)
		return require("configs.relativetoggle")(opts)
	end,
}
