return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	keys = {
		{
			"ff",
			function()
				require("conform").format({ lsp_fallback = true })
			end,
			desc = "Format buffer",
		},
	},
	opts = require("configs.conform"),
}
