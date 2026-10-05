return function(opts)
	local options = {
		locales = { "en", "zh" },
		sources = {
			"src/locales/{locales}.json",
		},
	}

	return opts and vim.tbl_deep_extend("force", opts, options) or options
end
