local options = {
	locales = { "en", "zh" },
	sources = {
		"src/locales/{locales}.json",
	},
}

require("i18n").setup(options)
