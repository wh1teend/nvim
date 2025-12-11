require("nvchad.autocmds")

local helpers = require("helpers")

---@diagnostic disable
helpers.autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
