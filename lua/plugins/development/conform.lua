return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	keys = {
		{
			"ff",
			function()
				require("conform").format({ lsp_format = "fallback" })
			end,
			desc = "Format buffer",
		},
	},
	opts = function(_, opts)
		return require("configs.development.conform")(opts)
	end,
}
