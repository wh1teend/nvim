return {
	"hiphish/rainbow-delimiters.nvim",
	event = "BufReadPost",
	config = function()
		require("configs.rainbowdelimiters")
	end,
}
