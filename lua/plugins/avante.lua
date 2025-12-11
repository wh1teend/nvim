return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	build = "make",
	opts = function()
		return require("configs.avante")
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"echasnovski/mini.pick",
		"nvim-telescope/telescope.nvim",
		"hrsh7th/nvim-cmp",
		"ibhagwan/fzf-lua",
		"nvim-tree/nvim-web-devicons",
		{
			"zbirenbaum/copilot.lua",
			cmd = "Copilot",
			opts = function()
				return require("configs.ai.copilot")
			end,
		},
		{
			"ravitemer/mcphub.nvim",
			cmd = "MCPHub",
			dependencies = { "nvim-lua/plenary.nvim" },
			build = "npm install -g mcp-hub@latest",
			opts = function()
				return require("configs.mcphub")
			end,
		},
		{
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = { insert_mode = true },
					use_absolute_path = true,
				},
			},
		},
		{
			"MeanderingProgrammer/render-markdown.nvim",
			ft = { "markdown", "Avante" },
			opts = {
				file_types = { "markdown", "Avante" },
			},
		},
	},
}
