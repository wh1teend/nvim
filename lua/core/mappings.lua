require("nvchad.mappings")

local map = require("utils").map

map("i", "jj", "<Esc>", { desc = "Exit insert mode" })
map("v", "ff", "<Esc>", { desc = "Exit visual mode" })

map("n", "<C-t>", function()
	require("menu").open("default")
end, { desc = "Open menu" })

map({ "n", "v" }, "<RightMouse>", function()
	require("menu.utils").delete_old_menus()

	vim.cmd.exec('"normal! \\<RightMouse>"')

	local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
	local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"

	require("menu").open(options, { mouse = true })
end, { desc = "Open context menu" })
