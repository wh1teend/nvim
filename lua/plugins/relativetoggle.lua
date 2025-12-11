return {
	"cpea2506/relative-toggle.nvim",
	event = { "BufEnter", "InsertEnter" },
	config = function()
		require("relative-toggle").setup()
	end,
}
