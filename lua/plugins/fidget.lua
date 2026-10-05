return {
	"j-hui/fidget.nvim",
	event = "LspAttach",
	opts = function(_, opts)
		return require("configs.fidget")(opts)
	end,
}
