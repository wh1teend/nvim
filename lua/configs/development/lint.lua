return function()
	local utils = require("utils")
	local lint = require("lint")

	local language = require("language")
	for _, profile in pairs(language.languages) do
		if profile.linter_options then
			for name, options in pairs(profile.linter_options) do
				lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], options)
			end
		end
	end

	local linters_by_ft = {}
	for _, profile in pairs(language.languages) do
		if profile.linters then
			for _, filetype in ipairs(profile.filetypes) do
				linters_by_ft[filetype] = vim.deepcopy(profile.linters)
			end
		end
	end

	lint.linters_by_ft = linters_by_ft
	local wrap_linter = require("configs.development.linters.project_cwd")()

	utils.autocmd("BufWritePost", {
		callback = function()
			lint.try_lint(nil, { wrap_linter = wrap_linter })
		end,
	})
end
