return function(opts)
	local language = require("language")
	local formatters_by_ft = {}
	local format_on_save_by_ft = {}

	for _, profile in pairs(language.languages) do
		for _, filetype in ipairs(profile.filetypes) do
			if profile.formatters then
				formatters_by_ft[filetype] = vim.deepcopy(profile.formatters)
			end
			if profile.format_on_save then
				format_on_save_by_ft[filetype] = vim.deepcopy(profile.format_on_save)
			end
		end
	end

	local options = {
		formatters_by_ft = formatters_by_ft,

		format_on_save = function(bufnr)
			local format_options = vim.deepcopy(language.format_on_save)
			local overrides = format_on_save_by_ft[vim.bo[bufnr].filetype]

			if overrides then
				format_options = vim.tbl_deep_extend("force", format_options, overrides)
			end

			return format_options
		end,
	}

	return opts and vim.tbl_deep_extend("force", opts, options) or options
end
