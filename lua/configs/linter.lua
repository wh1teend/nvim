local utils = require("utils")

require("lint").linters_by_ft = require("language").linters

utils.autocmd("BufWritePost", {
	callback = function()
		require("lint").try_lint()
	end,
})
