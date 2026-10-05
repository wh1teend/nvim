return {
	"sontungexpt/better-diagnostic-virtual-text",
	event = "LspAttach",
	opts = function(_, opts)
		return require("configs.diagnostic")(opts)
	end,
}
