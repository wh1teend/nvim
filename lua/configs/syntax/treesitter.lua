return function(opts)
	local parsers = {}
	local seen = {}

	for _, profile in pairs(require("language").languages) do
		for _, parser in ipairs(profile.highlighting or {}) do
			if not seen[parser] then
				seen[parser] = true
				table.insert(parsers, parser)
			end
		end
	end
	table.sort(parsers)

	local options = {
		ensure_installed = parsers,
	}

	return opts and vim.tbl_deep_extend("force", opts, options) or options
end
