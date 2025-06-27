local options = {
  highlight = "Comment",
  include_paren = true,
  anywhere_on_line = true,
  show_same_line_opening = false,

  excluded_buftypes = {
    "terminal",
  },
}

require("paren-hint").setup(options)
