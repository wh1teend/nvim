return {
	"ph1losof/ecolog.nvim",
	branch = "v1",
	lazy = false,
	opts = function(_, opts)
		return require("configs.workflow.ecolog")(opts)
	end,
}
