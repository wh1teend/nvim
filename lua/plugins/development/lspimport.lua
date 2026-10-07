return {
	"stevanmilic/nvim-lspimport",
	build = function(plugin)
		local directory = plugin.dir .. "/build/lua/lspimport"
		vim.fn.mkdir(directory, "p")
		local source = table.concat(vim.fn.readfile(plugin.dir .. "/lua/lspimport/init.lua"), "\n")
		source = source:gsub(
			"local lsp_to_complete_items = function%(result, prefix%)\n.-\nend",
			"local lsp_to_complete_items = vim.lsp.completion._lsp_to_complete_items"
		)
		vim.fn.writefile(vim.split(source, "\n", { plain = true }), directory .. "/init.lua")
		local servers = table.concat(vim.fn.readfile(plugin.dir .. "/lua/lspimport/servers.lua"), "\n")
		servers = servers:gsub(
			'item.menu == "Auto%-import"',
			'item.user_data.nvim.lsp.completion_item.detail == "Auto-import"'
		)
		vim.fn.writefile(vim.split(servers, "\n", { plain = true }), directory .. "/servers.lua")
	end,
	config = function(plugin)
		vim.opt.runtimepath:prepend(plugin.dir .. "/build")
	end,
	ft = "python",
	keys = {
		{
			"<leader>lI",
			function()
				require("lspimport").import()
			end,
			ft = "python",
			desc = "Import unresolved Python symbol",
		},
	},
}
