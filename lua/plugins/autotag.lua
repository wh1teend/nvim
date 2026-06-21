return {
	"windwp/nvim-ts-autotag",
	event = "BufReadPre",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = require("configs.autotag"),
}
