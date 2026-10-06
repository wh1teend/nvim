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
			lsp = { { "lua_ls" } },
			formatters = { "stylua" },
			linters = { "luacheck" },
			highlighting = { "lua" },
			filetypes = { "lua" },

			dap = {
				{
					adapter = { "nlua", lua_debug.adapter },
					configurations = lua_debug.configurations,
				},
			},

			linter_options = {
				luacheck = require("configs.development.linters.luacheck")(),
			},
		},

		vim = {
			lsp = { { "vimls" } },
			linters = { "vint" },
			highlighting = { "vim" },
			filetypes = { "vim" },
		},

		vimdoc = {
			highlighting = { "vimdoc" },
			filetypes = { "vimdoc" },
		},

		html = {
			lsp = { { "html" } },
			formatters = { "prettierd" },
			linters = { "htmlhint" },
			highlighting = { "html" },
			filetypes = { "html" },
		},

		css = {
			lsp = { { "cssls" } },
			highlighting = { "css" },
			formatters = { "prettierd" },
			filetypes = { "css", "scss", "less" },
		},

		json = {
			lsp = { { "jsonls" } },
			highlighting = { "json", "jsonc" },
			formatters = { "prettierd" },
			filetypes = { "json", "jsonc" },
		},

		prisma = {
			lsp = { { "prismals" } },
			highlighting = { "prisma" },
			filetypes = { "prisma" },
		},

		php = {
			lsp = { { "intelephense", php.intelephense } },
			formatters = { "easy-coding-standard" },
			linters = { "phpstan" },
			highlighting = { "php" },
			filetypes = { "php" },

			dap = {
				{
					"php-debug-adapter",
					adapter = { "php", php_debug.adapter },
					configurations = php_debug.configurations,
				},
			},

			format_on_save = { timeout_ms = 2000 },
		},

		python = {
			lsp = { { "pyright" } },
			formatters = { "black" },
			linters = { "ruff" },
			highlighting = { "python" },
			filetypes = { "python" },

			dap = {
				{
					"debugpy",
					adapter = { "python", python_debug.adapter },
					configurations = python_debug.configurations,
				},
			},

			venv = { ".venv", "venv", "env" },
		},

		go = {
			lsp = { { "gopls" } },
			formatters = { "goimports", "gofumpt" },
			linters = { "golangcilint" },
			highlighting = { "go" },
			filetypes = { "go" },

			dap = {
				{
					"delve",
					adapter = {
						"delve",
						go_debug.adapter,
					},
					configurations = go_debug.configurations,
				},
			},
		},

		javascript = {
			lsp = { { "vtsls", vue.vtsls } },
			formatters = { "prettierd" },
			linters = { "eslint_d" },
			highlighting = { "javascript", "typescript" },
			filetypes = { "javascript", "typescript" },

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

			tools = {
				i18n = {
					locales = { "en", "zh" },
					sources = { "src/locales/{locales}.json" },
				},
			},
		},

		react = {
			formatters = { "prettierd" },
			linters = { "eslint_d" },
			highlighting = { "javascript", "tsx" },
			filetypes = { "javascriptreact", "typescriptreact" },

			tools = {
				boundary = { auto = true },
			},
		},

		vue = {
			lsp = { { "vue_ls", vue.vue_ls } },
			formatters = { "prettierd" },
			linters = { "eslint_d" },
			filetypes = { "vue" },
			highlighting = { "vue" },
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
