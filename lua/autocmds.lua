require("nvchad.autocmds")

local helpers = require("helpers")

helpers.autocmd({ "BufReadPost" }, {
	callback = function()
		vim.bo.modifiable = true
	end,
})

helpers.autocmd({ "BufReadPost", "BufNewFile" }, {
	callback = function()
		vim.bo.fileencoding = "utf-8"
	end,
})

helpers.autocmd("LspAttach", {
	callback = function()
		vim.diagnostic.config({
			virtual_text = {
				format = function(diagnostic)
					if diagnostic.source then
						return string.format("[%s] %s", diagnostic.source, diagnostic.message)
					end
					return diagnostic.message
				end,
			},
		})
	end,
})
