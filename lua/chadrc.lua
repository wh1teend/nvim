local M = {}

M.base46 = {
  theme = "ayu_dark",
  theme_toggle = {
    "ayu_dark",
    "ayu_light",
  },
}

M.ui = {
  cmp = {
    lspkind_text = true,
    style = "default",
    format_colors = {
      tailwind = true,
    },
  },

  telescope = {
    style = "bordered",
  },

  statusline = {
    enabled = true,
    theme = "default",
    separator_style = "block",
  },

  tabufline = {
    enabled = true,
    lazyload = true,
    order = {
      "treeOffset",
      "buffers",
      "tabs",
      "btns",
    },
  },
}

M.colorify = {
  enabled = true,
  mode = "virtual",
  virt_text = "󱓻 ",
  highlight = {
    hex = true,
    lspvars = true,
  },
}

return M
