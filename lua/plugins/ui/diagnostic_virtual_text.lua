return {
	"sontungexpt/better-diagnostic-virtual-text",
	event = "LspAttach",
	opts = function(_, opts)
		return require("configs.ui.diagnostic_virtual_text")(opts)
	end,
}
