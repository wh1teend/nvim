require("nvchad.configs.lspconfig").defaults()

local language = require "../language"

for _, entry in ipairs(language.lsp.configs) do
  vim.lsp.config(entry[1], entry[2])
end

vim.lsp.enable(language.lsp)
