local vue = require("configs.development.lsp.vue")()
local php = require("configs.development.lsp.php")()
local javascript = require("configs.development.dap.javascript")()
local python_debug = require("configs.development.dap.python")()
local go_debug = require("configs.development.dap.go")()
local php_debug = require("configs.development.dap.php")()
local lua_debug = require("configs.development.dap.lua")()

local options = {
	languages = {
		lua = {
			filetypes = { "lua" },
			highlighting = { "lua" },
			lsp = { { "lua_ls" } },
			formatters = { "stylua" },
			linters = { "luacheck" },
            linter_options = {
                luacheck = require("configs.development.linters.luacheck")(),
            },
			dap = {
                {
                    adapter = { "nlua", lua_debug.adapter },
                    configurations = lua_debug.configurations,
                },
			},
		},
		vim = {
			filetypes = { "vim" },
			highlighting = { "vim" },
			lsp = { { "vimls" } },
			linters = { "vint" },
		},
        vimdoc = {
            filetypes = { "vimdoc" },
            highlighting = { "vimdoc" },
        },
		html = {
			filetypes = { "html" },
			highlighting = { "html" },
			lsp = { { "html" } },
			formatters = { "prettierd" },
			linters = { "htmlhint" },
		},
		css = {
			filetypes = { "css", "scss", "less" },
			highlighting = { "css" },
			lsp = { { "cssls" } },
			formatters = { "prettierd" },
		},
		json = {
			filetypes = { "json", "jsonc" },
			highlighting = { "json", "jsonc" },
			lsp = { { "jsonls" } },
			formatters = { "prettierd" },
		},
		prisma = {
			filetypes = { "prisma" },
			highlighting = { "prisma" },
			lsp = { { "prismals" } },
		},
		php = {
			filetypes = { "php" },
			highlighting = { "php" },
            lsp = {
                { "intelephense", php.intelephense },
            },
			formatters = { "easy-coding-standard" },
			linters = { "phpstan" },
			format_on_save = { timeout_ms = 2000 },
			dap = {
				{
					"php-debug-adapter",
					adapter = { "php", php_debug.adapter },
					configurations = php_debug.configurations,
				},
			},
		},
		python = {
			filetypes = { "python" },
			highlighting = { "python" },
			lsp = { { "pyright" } },
			formatters = { "black" },
			linters = { "ruff" },
			venv = { ".venv", "venv", "env" },
			dap = {
				{
					"debugpy",
					adapter = { "python", python_debug.adapter },
					configurations = python_debug.configurations,
				},
			},
		},
		go = {
			filetypes = { "go" },
			highlighting = { "go" },
			lsp = { { "gopls" } },
			formatters = { "goimports", "gofumpt" },
			linters = { "golangcilint" },
			dap = {
				{ "delve", adapter = { "delve", go_debug.adapter }, configurations = go_debug.configurations },
			},
		},
		javascript = {
			filetypes = { "javascript", "typescript" },
			highlighting = { "javascript", "typescript" },
			lsp = { { "vtsls", vue.vtsls } },
			formatters = { "prettierd" },
			linters = { "eslint_d" },
			dap = {
				{
					"js-debug-adapter",
					adapter = { "pwa-node", javascript.node_adapter },
					configurations = javascript.configurations,
				},
				{
					"js-debug-adapter",
					adapter = { "pwa-chrome", javascript.browser_adapter },
					filetypes = { "javascriptreact", "typescriptreact", "vue", "html" },
					configurations = javascript.browser_configurations,
				},
			},
			tools = { i18n = { locales = { "en", "zh" }, sources = { "src/locales/{locales}.json" } } },
		},
		react = {
			filetypes = { "javascriptreact", "typescriptreact" },
			highlighting = { "javascript", "tsx" },
			formatters = { "prettierd" },
			linters = { "eslint_d" },
			tools = { boundary = { auto = true } },
		},
		vue = {
			filetypes = { "vue" },
			highlighting = { "vue" },
			lsp = { { "vue_ls", vue.vue_ls } },
			formatters = { "prettierd" },
			linters = { "eslint_d" },
		},
	},

	packages = {
		lua_ls = "lua-language-server",
		vimls = "vim-language-server",
		html = "html-lsp",
		cssls = "css-lsp",
		jsonls = "json-lsp",
		prismals = "prisma-language-server",
		vue_ls = "vue-language-server",
		golangcilint = "golangci-lint",
	},

	mason = {
		run_on_start = true,
		start_delay = 2000,
	},

	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
}

return options
