require("nvchad.configs.lspconfig").defaults()

-- read :h vim.lsp.config for changing options of lsp servers
vim.lsp.enable(require("../language").lsp)
