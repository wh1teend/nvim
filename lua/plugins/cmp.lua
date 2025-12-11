return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		{
			"Exafunction/windsurf.nvim",
			cmd = "Codeium",
			config = function()
				require("configs.ai.codeium")
			end,
		},
		{
			"roobert/tailwindcss-colorizer-cmp.nvim",
			opts = {
				color_square_width = 2,
			},
		},
	},
	config = function(_, opts)
		local sources_to_add = {
			{ name = "codeium" },
		}

		for i, source in ipairs(sources_to_add) do
			table.insert(opts.sources, i + 1, source)
		end

		opts.experimental = {
			ghost_text = false,
		}

		require("cmp").config.formatting = {
			format = require("tailwindcss-colorizer-cmp").formatter,
		}

		require("cmp").setup(opts)
	end,
}
