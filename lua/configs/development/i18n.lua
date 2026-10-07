return function(opts)
	local options = vim.deepcopy(require("language").languages.javascript.tools.i18n)

	return opts and vim.tbl_deep_extend("force", opts, options) or options
end
