return function(opts)
	local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
	local mason_package = {
		schema = "registry+v1",
		name = "typescript-plugin-css-modules",
		description = "TypeScript language service plugin for CSS Modules",
		homepage = "https://github.com/mrmckeb/typescript-plugin-css-modules",
		licenses = { "MIT" },
		languages = { "TypeScript", "JavaScript", "CSS" },
		categories = { "LSP" },
		source = {
			id = "pkg:npm/typescript-plugin-css-modules@5.2.0",
		},
	}

	local options = {
		settings = {
			vtsls = {
				tsserver = {
					globalPlugins = {
						{
							name = "typescript-plugin-css-modules",
							location = mason_packages .. "/typescript-plugin-css-modules",
							languages = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
							enableForWorkspaceTypeScriptVersions = true,
						},
						{
							name = "@vue/typescript-plugin",
							location = mason_packages .. "/vue-language-server/node_modules/@vue/language-server",
							languages = { "vue" },
							configNamespace = "typescript",
						},
					},
				},
			},
		},
		filetypes = {
			"typescript",
			"javascript",
			"javascriptreact",
			"typescriptreact",
			"vue",
		},
	}

	return opts and vim.tbl_deep_extend("force", opts, options) or options, mason_package
end
