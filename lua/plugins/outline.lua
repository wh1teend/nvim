return {
	"hedyhli/outline.nvim",
	cmd = { "Outline", "OutlineOpen" },
	keys = {
		{ "<leader>oo", "<cmd>Outline<CR>", desc = "Toggle Outline" },
	},
	opts = function(_, opts)
		return require("configs.outline")(opts)
	end,
}
