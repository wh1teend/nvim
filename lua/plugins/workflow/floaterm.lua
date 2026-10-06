return {
	"nvzone/floaterm",
	dependencies = { "nvzone/volt" },
	cmd = { "FloatermToggle" },
	opts = function(_, opts)
		return require("configs.workflow.floaterm")(opts)
	end,
}
