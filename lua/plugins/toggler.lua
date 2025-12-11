return {
	"nguyenvukhang/nvim-toggler",
	keys = {
		{ "<leader>i", desc = "Toggle word" },
	},
	config = function()
		require("nvim-toggler").setup({
			inverses = {
				["true"] = "false",
				["yes"] = "no",
				["on"] = "off",
				["enabled"] = "disabled",
				["enable"] = "disable",
				["success"] = "failure",
				["&&"] = "||",
			},
		})

		vim.keymap.set("n", "<leader>i", require("nvim-toggler").toggle, { desc = "Toggle word" })
	end,
}
