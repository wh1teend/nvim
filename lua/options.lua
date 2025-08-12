require("nvchad.options")

local config = {
	g = {
		autosave = false,
	},

	diagnostic = {
		virtual_text = {
			source = false,
		},
		float = {
			source = "always",
		},
	},

	opt = {
		mouse = "a",
		number = true,
		numberwidth = 4,
		modifiable = true,
		relativenumber = true,
		fileencoding = "utf-8",
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
