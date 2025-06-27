require "nvchad.options"

local config = {
  g = {
    autosave = false,
  },

  opt = {
    mouse = "a",
    number = true,
    numberwidth = 4,
    modifiable = true,
    relativenumber = true,
    fileencoding = "utf-8",
  },

  hl = {
    NormalMode = "#00b3eb",
    InsertMode = "#ab78d2",
    VisualMode = "#78e9c9",
    CommandMode = "#9dda24",
  },
}

---@diagnostic disable
for section, values in pairs(config) do
  for key, value in pairs(values) do
    if section == "hl" then
      vim.api.nvim_set_hl(0, key, { fg = value })
    else
      vim[section][key] = value
    end
  end
end
