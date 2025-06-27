local options = {
  formatters_by_ft = require("../language").formatters,

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
