local helpers = require "helpers"

helpers.create_cmd("Q", "q", {
  desc = "Quit file (as :q)",
})

helpers.create_cmd("Qa", "qa", {
  desc = "Quit all files (as :qa)",
})

helpers.create_cmd("W", "w", {
  desc = "Save file (as :w)",
})

helpers.create_cmd("Lint", function()
  require("lint").try_lint()
  helpers.echo { { "Linting started for current buffer", "Title" } }
end, {
  desc = "Run linting on current buffer",
})
