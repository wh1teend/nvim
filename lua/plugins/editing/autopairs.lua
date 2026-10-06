return {
	"windwp/nvim-autopairs",
	opts = function(_, opts)
		return require("configs.editing.autopairs")(opts)
	end,
}
