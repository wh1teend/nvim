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
	},
}

return options
