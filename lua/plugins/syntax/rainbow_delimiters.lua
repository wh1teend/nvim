return {
	"hiphish/rainbow-delimiters.nvim",
	event = "BufReadPost",
	config = function(_, opts)
		return require("configs.syntax.rainbow_delimiters")(opts)
	end,
}
