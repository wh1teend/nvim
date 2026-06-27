require("nvchad.options")

local deprecate = vim.deprecate
vim.deprecate = function(name, ...)
	if type(name) == "string" and name:find("is_stopped", 1, true) then
		return
	end

	return deprecate(name, ...)
end

local config = {
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
			source = "always",
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

---@diagnostic disable
for section, values in pairs(config) do
	if section == "hl" then
		for key, value in pairs(values) do
			vim.api.nvim_set_hl(0, key, { fg = value })
		end
	elseif section == "diagnostic" then
		vim.diagnostic.config(values)
	else
		for key, value in pairs(values) do
			vim[section][key] = value
		end
	end
end
