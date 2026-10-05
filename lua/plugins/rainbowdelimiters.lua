return {
	"hiphish/rainbow-delimiters.nvim",
	event = "BufReadPost",
	config = function(_, opts)
		return require("configs.rainbowdelimiters")(opts)
	end,
}
