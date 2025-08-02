local vue = require "configs.lsp.vue"

return {
  lsp = {
    "html",
    "cssls",
    "pylsp",
    "ts_ls",
    "jsonls",
    "prismals",
    "intelephense",
    "vtsls",
    "vue_ls", -- :MasonInstall vue-language-server

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
  },

  linters = {
    php = { "phpstan" },
    python = { "ruff" },
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
    typescriptreact = { "eslint" },
    javascriptreact = { "eslint" },
  },
}
