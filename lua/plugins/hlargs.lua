return {
  "m-demare/hlargs.nvim",
  event = "BufWinEnter",
  config = function()
    require "configs.hlargs"
  end,
}
