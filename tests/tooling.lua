vim.opt.runtimepath:prepend(vim.fn.getcwd())

local original_cwd = vim.fn.getcwd()
local directory = vim.fn.tempname()
local buffers = {}
local resolve = require("project_root")()
local javascript = require("configs.development.dap.javascript")()
local python = require("configs.development.dap.python")()

local function file(path, contents)
	vim.fn.mkdir(vim.fs.dirname(path), "p")
	assert(vim.fn.writefile(contents or {}, path) == 0)
end

local function buffer(path, filetype)
	local bufnr = vim.api.nvim_create_buf(false, true)
	buffers[#buffers + 1] = bufnr
	vim.bo[bufnr].buftype = ""
	vim.api.nvim_buf_set_name(bufnr, path)
	vim.bo[bufnr].filetype = filetype
	vim.api.nvim_set_current_buf(bufnr)
	return bufnr
end

local function input(callback, value)
	vim.api.nvim_feedkeys(value == nil and "\r" or "\21" .. value .. "\r", "t", false)
	return callback()
end

local function equal(actual, expected)
	assert(actual == expected, vim.inspect({ actual = actual, expected = expected }))
end

local function matching_paths(patterns)
	local paths = {}
	for _, pattern in ipairs(patterns) do
		if pattern:sub(1, 1) ~= "!" then
			for _, path in ipairs(vim.fn.glob(pattern, false, true)) do
				paths[path] = true
			end
		end
	end
	return paths
end

local ok, failure = xpcall(function()
	file(directory .. "/a/package.json", { "{}" })
	file(directory .. "/a/src/main.ts", { "const marker: number = 42;" })
	file(directory .. "/a/dist/main.js", { "const marker = 42;" })
	file(directory .. "/a/dist/main.js.map", { "{}" })
	file(directory .. "/a/services/python/pyproject.toml", { "[project]", 'name = "sample-a"' })
	file(directory .. "/a/services/python/src/main.py", { "print('a')" })
	file(directory .. "/b/package.json", { "{}" })
	file(directory .. "/b/src/main.ts", { "const marker: number = 43;" })
	file(directory .. "/b/dist/main.js", { "const marker = 43;" })
	file(directory .. "/b/dist/main.js.map", { "{}" })
	file(directory .. "/b/services/python/pyproject.toml", { "[project]", 'name = "sample-b"' })
	file(directory .. "/b/services/python/src/main.py", { "print('b')" })
	file(directory .. "/standalone/main.lua", { "print('standalone')" })
	vim.fn.mkdir(directory .. "/unrelated", "p")
	vim.cmd("cd " .. vim.fn.fnameescape(directory .. "/unrelated"))

	local a = vim.uv.fs_realpath(directory .. "/a")
	local b = vim.uv.fs_realpath(directory .. "/b")
	local a_buffer = buffer(a .. "/src/main.ts", "typescript")
	equal(resolve({ "package.json" }), a)
	local b_buffer = buffer(b .. "/src/main.ts", "typescript")
	equal(resolve({ "package.json" }, a_buffer), a)
	equal(resolve({ "package.json" }), b)

	local python_a_buffer = buffer(a .. "/services/python/src/main.py", "python")
	equal(resolve({ "pyproject.toml" }), a .. "/services/python")
	equal(resolve({ "package.json" }), a)
	buffer(directory .. "/standalone/main.lua", "lua")
	equal(resolve({ ".luacheckrc" }), vim.uv.fs_realpath(directory .. "/standalone"))

	local node = javascript.configurations[1]
	local browser = javascript.browser_configurations[1]
	for _, project in ipairs({
		{ buffer = a_buffer, root = a, other = b, marker = "const marker: number = 42;" },
		{ buffer = b_buffer, root = b, other = a, marker = "const marker: number = 43;" },
		{ buffer = a_buffer, root = a, other = b, marker = "const marker: number = 42;" },
	}) do
		vim.api.nvim_set_current_buf(project.buffer)
		for _, configuration in ipairs(javascript.configurations) do
			if configuration.type == "pwa-node" then
				equal(vim.fn.readfile(configuration.cwd() .. "/src/main.ts")[1], project.marker)
				local output = matching_paths(configuration.outFiles())
				assert(output[project.root .. "/dist/main.js"])
				assert(not output[project.other .. "/dist/main.js"])
				local source_maps = matching_paths(configuration.resolveSourceMapLocations())
				assert(source_maps[project.root .. "/dist/main.js.map"])
				assert(not source_maps[project.other .. "/dist/main.js.map"])
			end
		end
		for _, configuration in ipairs(javascript.browser_configurations) do
			local web_root = configuration.webRoot()
			equal(vim.fn.readfile(web_root .. "/src/main.ts")[1], project.marker)
		end
	end

	local python_b_buffer = buffer(b .. "/services/python/src/main.py", "python")
	local python_mappings = python.configurations[2].pathMappings[1]
	for _, project in ipairs({
		{ buffer = python_a_buffer, contents = "print('a')" },
		{ buffer = python_b_buffer, contents = "print('b')" },
		{ buffer = python_a_buffer, contents = "print('a')" },
	}) do
		vim.api.nvim_set_current_buf(project.buffer)
		local relative = vim.fs.relpath(python_mappings.remoteRoot(), vim.api.nvim_buf_get_name(project.buffer))
		equal(relative, "src/main.py")
		local source = vim.fs.joinpath(python_mappings.localRoot(), relative)
		equal(vim.fn.readfile(source)[1], project.contents)
	end

	vim.api.nvim_set_current_buf(a_buffer)
	local program = node.program
	local url = browser.url
	equal(input(program, a .. "/dist/main.js"), a .. "/dist/main.js")
	equal(input(url, "http://localhost:6201"), "http://localhost:6201")
	vim.api.nvim_set_current_buf(b_buffer)
	equal(input(program, b .. "/dist/main.js"), b .. "/dist/main.js")
	equal(input(url, "http://localhost:6202"), "http://localhost:6202")
	vim.api.nvim_set_current_buf(a_buffer)
	equal(input(program), a .. "/dist/main.js")
	equal(input(url), "http://localhost:6201")
	equal(input(program, ""), "")
	equal(input(program), a .. "/dist/main.js")
	file(a .. "/dist/other.js", { "const marker = 44;" })
	equal(input(program, a .. "/dist/other.js"), a .. "/dist/other.js")
	equal(input(program), a .. "/dist/other.js")
	equal(input(url, "http://localhost:6203"), "http://localhost:6203")
	equal(input(url), "http://localhost:6203")
	vim.api.nvim_set_current_buf(b_buffer)
	equal(input(program), b .. "/dist/main.js")
	equal(input(url), "http://localhost:6202")

	local alias = directory .. "/alias"
	if vim.uv.fs_symlink(a, alias) then
		vim.api.nvim_set_current_buf(a_buffer)
		vim.api.nvim_buf_set_name(a_buffer, alias .. "/src/main.ts")
		equal(resolve({ "package.json" }), a)
		equal(input(program), a .. "/dist/other.js")
		equal(input(url), "http://localhost:6203")
	end

	vim.api.nvim_set_current_buf(a_buffer)
	vim.bo[a_buffer].filetype = "javascript"
	equal(program(), vim.api.nvim_buf_get_name(a_buffer))
	local unnamed = vim.api.nvim_create_buf(false, true)
	buffers[#buffers + 1] = unnamed
	vim.api.nvim_set_current_buf(unnamed)
	equal(resolve({ "package.json" }), vim.uv.fs_realpath(directory .. "/unrelated"))
end, debug.traceback)

for _, bufnr in ipairs(buffers) do
	if vim.api.nvim_buf_is_valid(bufnr) then
		vim.api.nvim_buf_delete(bufnr, { force = true })
	end
end
vim.cmd("cd " .. vim.fn.fnameescape(original_cwd))
vim.fn.delete(directory, "rf")
if not ok then
	io.stderr:write(tostring(failure) .. "\n")
	os.exit(1)
end
io.stdout:write(
	"Tooling regressions OK: project roots, dynamic DAP paths, Python mappings, prompt defaults, symlink identity, empty input\n"
)
os.exit(0)
