local options = {
  outline_window = {
    focus_on_open = false,
  },

  outline_items = {
    show_symbol_details = true,
    auto_set_cursor = true,
  },

  preview_window = {
    open_hover_on_preview = true,
  },
}

require("outline").setup(options)
