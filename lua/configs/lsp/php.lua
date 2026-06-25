local handle

local options = {
	intelephense = {
		root_markers = { "composer.json", "composer.lock", ".git" },
		settings = {
			intelephense = {
				files = {
					maxSize = 5000000,
					exclude = {
						"**/.git/**",
						"**/node_modules/**",
						"**/internal_data/**",
						"**/data/**",
						"**/_files/**",
					},
				},
			},
		},
		handlers = {
			["indexingStarted"] = function()
				if handle then
					handle:cancel()
				end

				handle = require("fidget.progress.handle").create({
					title = "Indexing",
					lsp_client = { name = "intelephense" },
				})
			end,
			["indexingEnded"] = function()
				if handle then
					handle:finish()
					handle = nil
				end
			end,
		},
	},
}

return options
