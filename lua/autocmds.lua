require "nvchad.autocmds"

local helpers = require "helpers"
local real_set_buf = vim.api.nvim_set_current_buf

---@diagnostic disable
helpers.autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

---@diagnostic disable
helpers.autocmd("BufEnter", {
  callback = function()
    vim.api.nvim_set_current_buf = function(bufnr)
      for _, buffer_name in ipairs { "NvimTree_1" } do
        if vim.api.nvim_buf_get_name(0):match(buffer_name) then
          return
        end
      end
      return real_set_buf(bufnr)
    end
  end,
})
