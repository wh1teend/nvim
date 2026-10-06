return function(opts)
	local options = {
		defaults = { lazy = true },
		install = { colorscheme = { require("chadrc").base46.theme } },

		ui = {
			icons = {
				ft = "",
				lazy = "󰂠 ",
				loaded = "",
				not_loaded = "",
			},
		},

		performance = {
			rtp = {
				disabled_plugins = {
					"2html_plugin",
					"tohtml",
					"getscript",
					"getscriptPlugin",
					"gzip",
					"logipat",
					"netrw",
					"netrwPlugin",
					"netrwSettings",
					"netrwFileHandlers",
					"matchit",
					"tar",
					"tarPlugin",
					"rrhelper",
					"spellfile_plugin",
					"vimball",
					"vimballPlugin",
					"zip",
					"zipPlugin",
					"tutor",
					"rplugin",
					"syntax",
					"synmenu",
					"optwin",
					"compiler",
					"bugreport",
					"ftplugin",
				},
			},
		},
	}

	return opts and vim.tbl_deep_extend("force", opts, options) or options
end
