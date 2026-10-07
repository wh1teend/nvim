return function(opts)
	local tools = require("language").languages.python.tools or {}
	local options = vim.deepcopy(tools.venv_selector or {})

	return opts and vim.tbl_deep_extend("force", opts, options) or options
end
