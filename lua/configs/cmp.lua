return function(_, opts)
	local sources_to_add = {
		{ name = "codeium" },
		{ name = "copilot" },
		{ name = "dotenv" },
	}

	for i, source in ipairs(sources_to_add) do
		table.insert(opts.sources, i + 1, source)
	end

	require("cmp").setup(opts)
end
