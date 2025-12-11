return {
	"matbme/JABS.nvim",
	cmd = "JABSOpen",
	keys = {
		{ "<leader>ls", "<cmd>JABSOpen<cr>", desc = "List Buffers (JABS)" },
		{ "<leader>bb", "<cmd>JABSOpen<cr>", desc = "Buffer Switcher" },
	},
	opts = {
		position = "corner",
		width = 60,
		height = 15,
		border = "rounded",
	},
}
