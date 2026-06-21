require("nvchad.autocmds")

local utils = require("utils")

utils.autocmd({ "BufReadPost" }, {
	callback = function()
		vim.bo.modifiable = true
	end,
})

utils.autocmd({ "BufReadPost", "BufNewFile" }, {
	callback = function()
		vim.bo.fileencoding = "utf-8"
	end,
})
