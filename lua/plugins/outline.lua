return {
  "hedyhli/outline.nvim",
  event = "VeryLazy",
  cmd = { "Outline", "OutlineOpen" },
  init = function()
    vim.keymap.set("n", "<leader>oo", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
  end,
  config = function()
    require "configs.outline"
  end,
}
