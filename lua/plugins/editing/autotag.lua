return {
	"windwp/nvim-ts-autotag",
	event = "BufReadPre",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = function(_, opts)
		return require("configs.editing.autotag")(opts)
	end,
}
