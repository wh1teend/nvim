return {
  "Fildo7525/pretty_hover",
  event = "LspAttach",
  init = function()
    vim.keymap.set("n", "K", function()
      require("pretty_hover").hover()
    end)
  end,
}
