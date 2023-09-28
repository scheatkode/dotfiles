return {
	"lukas-reineke/indent-blankline.nvim",

	event = {
		"FileType",
	},

	main = "ibl",

	opts = {
		-- default configuration

		indent = {
			char = "│",
			smart_indent_cap = true,
			tab_char = "│",
		},

		scope = {
			show_start = false,
			show_end = false,
		},

		exclude = {
			filetypes = {
				"TelescopePrompt",
				"TelescopeResults",
				"checkhealth",
				"fugitive",
				"gitcommit",
				"help",
				"lspinfo",
				"man",
				"markdown",
				"norg",
				"oil",
			},
		},
	},
}
