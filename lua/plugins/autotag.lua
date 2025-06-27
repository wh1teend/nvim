return {
  "windwp/nvim-ts-autotag",
  event = "BufReadPre",
  config = function()
    require "configs.autotag"
  end,
}
