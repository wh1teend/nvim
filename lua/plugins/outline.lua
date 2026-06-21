return {
	"hedyhli/outline.nvim",
	cmd = { "Outline", "OutlineOpen" },
	keys = {
		{ "<leader>oo", "<cmd>Outline<CR>", desc = "Toggle Outline" },
	},
	opts = require("configs.outline"),
}
