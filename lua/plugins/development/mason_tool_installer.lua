return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = { "mason-org/mason.nvim" },
	event = "VeryLazy",
	opts = function(_, opts)
		local language = require("language")

		local package_names = language.packages

		local seen = {}
		local ensure_installed = {}

		local function add(name)
			local pkg = package_names[name] or name
			if not seen[pkg] then
				seen[pkg] = true
				table.insert(ensure_installed, pkg)
			end
		end

		local function add_all(tools)
			if not tools then
				return
			end

			for _, tool in ipairs(tools) do
				add(tool)
			end
		end

		for _, profile in pairs(language.languages) do
			for _, entry in ipairs(profile.lsp or {}) do
				add(entry[1])
			end
			add_all(profile.lsp_plugins)

			add_all(profile.formatters)
			add_all(profile.linters)

			for _, settings in ipairs(profile.dap or {}) do
				if settings[1] then
					add(settings[1])
				end
			end
		end

		table.sort(ensure_installed)
		local options = vim.deepcopy(language.mason)
		options.ensure_installed = ensure_installed
		return vim.tbl_deep_extend("force", opts or {}, options)
	end,
}
