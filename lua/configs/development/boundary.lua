return function(opts)
	local options = vim.deepcopy(require("language").languages.react.tools.boundary)

	return opts and vim.tbl_deep_extend("force", opts, options) or options
end
