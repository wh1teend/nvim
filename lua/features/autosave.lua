local M = {}

function M.setup()
	local utils = require("utils")

	utils.autocmd({ "InsertLeave", "TextChanged" }, {
		nested = true,
		callback = function()
			if vim.g.autosave and #vim.api.nvim_buf_get_name(0) ~= 0 and vim.bo.buflisted then
				vim.cmd("silent w")

				utils.echo({ { "󰄳", "LazyProgressDone" }, { " File autosaved at " .. os.date("%I:%M %p") } })

				utils.clear(800)
			end
		end,
	})

	utils.create_cmd("AsToggle", function()
		vim.g.autosave = not vim.g.autosave

		local enabled_text = { { "󰆓 ", "LazyProgressDone" }, { "autosave enabled!" } }
		local disabled_text = { { "  ", "LazyNoCond" }, { "autosave disabled" } }

		utils.echo(vim.g.autosave and enabled_text or disabled_text)

		utils.clear(800)
	end, {})
end

return M
