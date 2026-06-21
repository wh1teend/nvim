local vue = require("configs.lsp.vue")

return {
	lsp = {
		servers = {
			"html",
			"cssls",
			"pyright",
			"jsonls",
			"prismals",
			"intelephense",
			"vtsls",
			"vue_ls",
			"gopls",
		},

		configs = {
			{
				"vtsls",
				vue.vtsls,
			},

			{
				"vue_ls",
				vue.vue_ls,
			},
		},
	},

	highlighting = {
		"vim",
		"lua",
		"css",
		"php",
		"html",
		"json",
		"vimdoc",
		"python",
		"typescript",
		"javascript",
		"prisma",
		"go",
	},

	formatters = {
		php = { "easy-coding-standard" },
		lua = { "stylua" },
		css = { "prettierd" },
		html = { "prettierd" },
		json = { "prettierd" },
		python = { "black" },
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescriptreact = { "prettierd" },
		go = { "gofumpt", "goimports" },
	},

	linters = {
		php = { "phpstan" },
		python = { "ruff" },
		javascript = { "eslint_d" },
		typescript = { "eslint_d" },
		typescriptreact = { "eslint" },
		javascriptreact = { "eslint" },
		go = { "golangcilint" },
	},

	debuggers = {
		"js-debug-adapter",
	},

	mason_packages = {
		html = "html-lsp",
		cssls = "css-lsp",
		jsonls = "json-lsp",
		prismals = "prisma-language-server",
		vue_ls = "vue-language-server",
		golangcilint = "golangci-lint",
	},
}
