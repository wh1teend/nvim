local M = {}

function M.setup()
	require("nvchad.options")

	local deprecate = vim.deprecate
	vim.deprecate = function(name, ...)
		if type(name) == "string" and name:find("is_stopped", 1, true) then
			return
		end

		return deprecate(name, ...)
	end

	local options = {
		g = {
			autosave = false,
		},

		diagnostic = {
			virtual_text = {
				source = false,
				format = function(diagnostic)
					if diagnostic.source then
						return string.format("[%s] %s", diagnostic.source, diagnostic.message)
					end
					return diagnostic.message
				end,
			},
			float = {
				source = true,
			},
		},

		opt = {
			mouse = "a",
			number = true,
			numberwidth = 4,
			relativenumber = true,
		},

		hl = {
			NormalMode = "#00b3eb",
			InsertMode = "#ab78d2",
			VisualMode = "#78e9c9",
			CommandMode = "#9dda24",
		},
	}

	for name, value in pairs(options.g) do
		vim.g[name] = value
	end

	vim.diagnostic.config(options.diagnostic)

	for name, value in pairs(options.opt) do
		vim.opt[name] = value
	end

	for name, color in pairs(options.hl) do
		vim.api.nvim_set_hl(0, name, { fg = color })
	end
end

return M
