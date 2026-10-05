return {
	"Kenzo-Wada/boundary.nvim",
	branch = "release",
	event = "VeryLazy",
	opts = function(_, opts)
		return require("configs.tools.react")(opts)
	end,
}
