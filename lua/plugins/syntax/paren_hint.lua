return {
	"briangwaltney/paren-hint.nvim",
	event = "VeryLazy",
	opts = function(_, opts)
		return require("configs.syntax.paren_hint")(opts)
	end,
}
