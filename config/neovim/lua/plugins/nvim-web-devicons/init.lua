return {
	"kyazdani42/nvim-web-devicons",

	opts = {
		default = true,

		override = {
			jinja = {
				-- close enough.
				icon = "關",
				color = "#c00000",
				cterm_color = "9",
				name = "Jinja2",
			},

			sls = {
				-- close enough.
				icon = "◳",
				color = "#dddddd",
				cterm_color = "15",
				name = "Salt",
			},

			yaml = {
				icon = "!",
				color = "#a074c4",
				cterm_color = "140",
				name = "Yaml",
			},
		},
	},
}
