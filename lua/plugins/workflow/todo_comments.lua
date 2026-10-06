return {
	"folke/todo-comments.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = function(_, opts)
		return require("configs.workflow.todo_comments")(opts)
	end,
}
