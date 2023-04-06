return {
	"lukas-reineke/indent-blankline.nvim",

	event = {
		"FileType",
	},

	opts = {
		-- default configuration

		char = "│",
		indent_level = 10,
		viewport_buffer = 80,

		-- treesitter related configuration

		use_treesitter = true,
		show_current_context = true,
		show_trailing_blankline_indent = false,

		show_end_of_line = true,

		context_patterns = {
			"arguments",
			"array",
			"block",
			"class",
			"for",
			"function",
			"if",
			"method",
			"object",
			"table",
			"while",
		},

		-- excludes

		buftype_exclude = {
			"nofile",
			"terminal",
		},

		filetype_exclude = {
			"fugitive",
			"help",
			"markdown",
			"norg",
			"oil",
		},
	},
}
