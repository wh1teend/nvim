return {
	"XXiaoA/atone.nvim",
	cmd = "Atone",
	opts = function(_, opts)
		return require("configs.editing.atone")(opts)
	end,
}
