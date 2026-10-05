return {
	"XXiaoA/atone.nvim",
	cmd = "Atone",
	opts = function(_, opts)
		return require("configs.atone")(opts)
	end,
}
