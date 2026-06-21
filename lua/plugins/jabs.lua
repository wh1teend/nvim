return {
	"matbme/JABS.nvim",
	cmd = "JABSOpen",
	keys = {
		{ "<leader>ls", "<cmd>JABSOpen<CR>", desc = "List Buffers (JABS)" },
		{ "<leader>bb", "<cmd>JABSOpen<CR>", desc = "Buffer Switcher" },
	},
	opts = require("configs.jabs"),
}
