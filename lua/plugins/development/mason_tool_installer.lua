return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = { "mason-org/mason.nvim" },
	event = "VeryLazy",
	opts = function(_, opts)
		return require("configs.development.mason_tool_installer")(opts)
	end,
}
