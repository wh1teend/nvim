return function()
	local resolve = require("project_root")()

	local roots = {
		eslint_d = {
			"eslint.config.js",
			"eslint.config.mjs",
			"eslint.config.cjs",
			"eslint.config.ts",
			"eslint.config.mts",
			"eslint.config.cts",
			".eslintrc",
			".eslintrc.json",
			".eslintrc.yml",
			".eslintrc.yaml",
			".eslintrc.js",
			".eslintrc.cjs",
			"package.json",
		},
		golangcilint = { "go.mod", ".golangci.yml", ".golangci.yaml", ".golangci.toml", ".golangci.json" },
		htmlhint = { ".htmlhintrc", "package.json" },
		luacheck = { ".luacheckrc", ".luacheckrc.lua" },
		phpstan = { "phpstan.neon", "phpstan.neon.dist", "phpstan.dist.neon", "composer.json" },
		ruff = { "pyproject.toml", "ruff.toml", ".ruff.toml" },
		vint = { ".vintrc", ".vintrc.yaml", ".vintrc.yml" },
	}

	return function(linter)
		local markers = roots[linter.name]
		if markers then
			linter.cwd = resolve(markers)
		end
		if linter.name == "golangcilint" then
			-- The built-in definition chooses file/package mode when first imported.
			-- Resolve it per buffer instead, after the project cwd has been selected.
			linter.args[#linter.args] = function()
				if vim.fs.root(0, { "go.mod" }) then
					return resolve()
				end
				return vim.api.nvim_buf_get_name(0)
			end
		end
		return linter
	end
end
