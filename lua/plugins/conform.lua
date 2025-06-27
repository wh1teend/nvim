return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  opts = require "configs.conform",
  init = function()
    vim.keymap.set("n", "ff", function()
      require("conform").format { lsp_fallback = true }
    end)
  end,
}
