local utils = require("utils")

utils.create_cmd("Q", "q", {
	desc = "Quit file (as :q)",
})

utils.create_cmd("Qa", "qa", {
	desc = "Quit all files (as :qa)",
})

utils.create_cmd("W", "w", {
	desc = "Save file (as :w)",
})

utils.create_cmd("Lint", function()
	require("lint").try_lint()
	utils.echo({ { "Linting started for current buffer", "Title" } })
end, {
	desc = "Run linting on current buffer",
})

utils.create_cmd("LspReindex", function()
	local bufnr = vim.api.nvim_get_current_buf()

	local managed = {}
	for _, name in ipairs(require("language").lsp.servers) do
		managed[name] = true
	end

	local names = {}
	for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
		if managed[client.name] then
			table.insert(names, client.name)
			client:stop(true)
		end
	end

	if #names == 0 then
		utils.echo({ { "No re-indexable LSP clients attached", "WarningMsg" } })
		return
	end

	vim.defer_fn(function()
		vim.cmd("silent! edit")
	end, 500)

	utils.echo({ { "Re-indexing LSP: " .. table.concat(names, ", "), "Title" } })
end, {
	desc = "Restart LSP clients to re-index",
})
