local options = {
  suggestion = {
    enabled = false,
  },

  panel = {
    enabled = false,
  },

  server_opts_overrides = {
    settings = {
      advanced = {
        delayCompletions = 75,
      },
    },
  },
}

require("copilot").setup(options)
