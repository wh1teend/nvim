return {
	"andersevenrud/nvim_context_vt",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	event = "VeryLazy",
	opts = function(_, opts)
		return require("configs.contextvt")(opts)
	end,
}
