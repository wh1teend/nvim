local language = require("language")

local package_names = language.mason_packages

local exclude = {
	eslint = true,
}

local seen = {}
local ensure_installed = {}

local function add(name)
	if exclude[name] then
		return
	end

	local pkg = package_names[name] or name
	if not seen[pkg] then
		seen[pkg] = true
		table.insert(ensure_installed, pkg)
	end
end

for _, server in ipairs(language.lsp.servers) do
	add(server)
end

for _, group in ipairs({ language.formatters, language.linters }) do
	for _, tools in pairs(group) do
		for _, tool in ipairs(tools) do
			add(tool)
		end
	end
end

for _, tool in ipairs(language.debuggers) do
	add(tool)
end

local options = {
	ensure_installed = ensure_installed,
	run_on_start = true,
	start_delay = 2000,
}

return options
