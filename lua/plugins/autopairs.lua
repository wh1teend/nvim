return {
	"windwp/nvim-autopairs",
	opts = function(_, opts)
		return require("configs.autopairs")(opts)
	end,
}
