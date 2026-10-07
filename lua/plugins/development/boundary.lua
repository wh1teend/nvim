return {
	"Kenzo-Wada/boundary.nvim",
	branch = "release",
	event = "VeryLazy",
	opts = function(_, opts)
		return require("configs.development.boundary")(opts)
	end,
}
