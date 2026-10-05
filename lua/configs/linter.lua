return function()
	local utils = require("utils")
	local lint = require("lint")

	lint.linters_by_ft = require("language").linters

	utils.autocmd("BufWritePost", {
		callback = function()
			lint.try_lint()
		end,
	})
end
