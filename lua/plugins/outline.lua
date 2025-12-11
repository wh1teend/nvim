return {
	"hedyhli/outline.nvim",
	cmd = { "Outline", "OutlineOpen" },
	keys = {
		{ "<leader>oo", "<cmd>Outline<CR>", desc = "Toggle Outline" },
	},
	config = function()
		require("configs.outline")
	end,
}
