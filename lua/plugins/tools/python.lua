return {
	{
		"linux-cultist/venv-selector.nvim",
		cmd = { "VenvSelect", "VenvSelectCached" },
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-telescope/telescope.nvim",
			"mfussenegger/nvim-dap-python",
		},
		config = function()
			require("venv-selector").setup({
				name = ".venv",
			})
		end,
	},
}
