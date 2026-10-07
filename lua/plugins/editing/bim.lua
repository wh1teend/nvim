return {
	"sontungexpt/bim.nvim",
	event = "InsertEnter",
	opts = function(_, opts)
		return require("configs.editing.bim")(opts)
	end,
}
