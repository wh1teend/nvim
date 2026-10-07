return {
	"ingur/floatty.nvim",
	keys = {
		{
			"<A-t>",
			mode = { "n", "t" },
			desc = "Toggle floating terminal",
		},
	},
	config = function()
		local terminal = require("floatty").setup({})

		vim.keymap.set({ "n", "t" }, "<A-t>", function()
			terminal.toggle()
		end, { desc = "Toggle floating terminal" })
	end,
}
