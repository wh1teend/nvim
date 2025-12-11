return {
	"linux-cultist/venv-selector.nvim",
	branch = "regexp",
	ft = "python",
	cmd = { "VenvSelect", "VenvSelectCached", "VenvSelectCurrent" },
	dependencies = {
		"neovim/nvim-lspconfig",
		{ "nvim-telescope/telescope.nvim", optional = true },
		{ "mfussenegger/nvim-dap-python", optional = true },
	},
	opts = {
		name = { ".venv", "venv", "env" }, -- Множественные имена
	},
}
