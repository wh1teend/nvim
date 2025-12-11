return {
	"windwp/nvim-ts-autotag",
	event = "BufReadPre",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = function()
		return require("configs.autotag")
	end,
}
