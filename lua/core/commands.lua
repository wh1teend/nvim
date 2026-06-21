local utils = require("utils")

utils.create_cmd("Q", "q", {
	desc = "Quit file (as :q)",
})

utils.create_cmd("Qa", "qa", {
	desc = "Quit all files (as :qa)",
})

utils.create_cmd("W", "w", {
	desc = "Save file (as :w)",
})

utils.create_cmd("Lint", function()
	require("lint").try_lint()
	utils.echo({ { "Linting started for current buffer", "Title" } })
end, {
	desc = "Run linting on current buffer",
})
