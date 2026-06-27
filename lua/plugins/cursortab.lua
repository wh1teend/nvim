return {
	"cursortab/cursortab.nvim",
	lazy = false,
	build = "cd server && go build",
	opts = require("configs.cursortab"),
}
