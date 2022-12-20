return {
	setup = function()
		local iguides = require('indent_blankline')

		-- -- will make screen redrawing slower but required as a workaround to prevent
		-- -- the ugly "highlight bleed" into the next line.
		-- -- TODO(scheatkode): Remove this when a fix is provided.
		-- vim.wo.colorcolumn = '999'

		iguides.setup({
			-- default configuration

			char = '│',
			indent_level = 10,
			viewport_buffer = 30,

			-- treesitter related configuration

			use_treesitter = true,
			show_current_context = true,
			show_trailing_blankline_indent = false,

			show_end_of_line = true,

			context_patterns = {
				'arguments',
				'array',
				'block',
				'class',
				'for',
				'function',
				'if',
				'method',
				'object',
				'table',
				'while',
			},

			-- excludes

			buftype_exclude = {
				'nofile',
				'terminal',
			},

			filetype_exclude = {
				'Outline',
				'help',
				'norg',
			},
		})
	end,
}
