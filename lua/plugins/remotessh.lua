return {
	"inhesrom/remote-ssh.nvim",
	branch = "master",
	dependencies = {
		"inhesrom/telescope-remote-buffer",
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
		"neovim/nvim-lspconfig",
		"rcarriga/nvim-notify",
	},
	cmd = { "RemoteOpen", "RemoteTreeBrowser", "RemoteTui", "RemoteSession", "RemoteTerminalNew" },
	opts = require("configs.remotessh"),
}
