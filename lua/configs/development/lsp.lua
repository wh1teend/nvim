return function()
	require("nvchad.configs.lspconfig").defaults()

	local language = require("language")

	local servers = {}
	for _, profile in pairs(language.languages) do
		for _, entry in ipairs(profile.lsp or {}) do
			if entry[2] then
				vim.lsp.config(entry[1], entry[2])
			end
			servers[entry[1]] = true
		end
	end

	local names = {}
	for name in pairs(servers) do
		table.insert(names, name)
	end
	table.sort(names)

	vim.lsp.enable(names)
end
