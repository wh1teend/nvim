return function()
	return {
		args = {
			"--formatter",
			"plain",
			"--codes",
			"--ranges",
			"--filename",
			function()
				return vim.api.nvim_buf_get_name(0)
			end,
			"--globals",
			"vim",
			"--",
			"-",
		},
	}
end
