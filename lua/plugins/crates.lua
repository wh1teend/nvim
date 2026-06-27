return {
	"Saecki/crates.nvim",
	tag = "stable",
	event = { "BufRead Cargo.toml" },
	opts = require("configs.crates"),
}
