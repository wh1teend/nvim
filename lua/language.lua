return {
  lsp = {
    "html",
    "cssls",
    "pylsp",
    "ts_ls",
    "jsonls",
    "prismals",
    "intelephense",
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
  },

  formatters = {
    php = { "easy-coding-standard" },
    lua = { "stylua" },
    css = { "prettierd" },
    html = { "prettierd" },
    json = { "prettierd" },
    python = { "prettierd" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescriptreact = { "prettierd" },
  },

  linters = {
    php = { "phpstan" },
    python = { "flake8" },
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
    typescriptreact = { "eslint_d" },
    javascriptreact = { "eslint_d" },
  },
}
