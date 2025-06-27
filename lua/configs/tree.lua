local options = {
  filters = {
    dotfiles = false,

    custom = {
      ".DS_Store",
      ".git",
    },

    exclude = {
      ".gitignore",
      ".env",
    },
  },
}

return options
