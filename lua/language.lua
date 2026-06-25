local vue = require("configs.lsp.vue")
local php = require("configs.lsp.php")

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

			{
				"intelephense",
				php.intelephense,
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
