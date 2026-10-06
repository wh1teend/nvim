return function()
	local dap = require("dap")

	vim.fn.sign_define("DapBreakpoint", {
		text = "●",
		texthl = "DapBreakpoint",
		linehl = "",
		numhl = "",
	})

	vim.fn.sign_define("DapBreakpointCondition", {
		text = "◆",
		texthl = "DapBreakpoint",
		linehl = "",
		numhl = "",
	})

	vim.fn.sign_define("DapBreakpointRejected", {
		text = "○",
		texthl = "DapBreakpoint",
		linehl = "",
		numhl = "",
	})

	vim.fn.sign_define("DapLogPoint", {
		text = "◎",
		texthl = "DapLogPoint",
		linehl = "",
		numhl = "",
	})

	vim.fn.sign_define("DapStopped", {
		text = "→",
		texthl = "DapStopped",
		linehl = "DapStoppedLine",
		numhl = "",
	})

	vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e51400" })
	vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef" })
	vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379" })
	vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#31353f" })

	local language = require("language")

	for _, profile in pairs(language.languages) do
		for _, settings in ipairs(profile.dap or {}) do
			local adapter = settings.adapter
			dap.adapters[adapter[1]] = vim.deepcopy(adapter[2])

			for _, filetype in ipairs(settings.filetypes or profile.filetypes) do
				dap.configurations[filetype] = vim.deepcopy(settings.configurations)
			end
		end
	end
end
