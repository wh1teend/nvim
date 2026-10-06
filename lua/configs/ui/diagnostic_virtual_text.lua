return function(opts)
	local options = {
		inline = true,
		ui = { arrow = "→" },
	}

	return opts and vim.tbl_deep_extend("force", opts, options) or options
end
