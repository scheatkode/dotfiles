return {
	setup = function()
		require('symbols-outline').setup({
			auto_preview           = false, -- whether to automatically show code preview
			highlight_hovered_item = true, -- whether to highlight the currently hovered symbol
			relative_width         = false, -- whether the above width is relative to the current window
			show_guides            = true, -- whether to show outline guides
			width                  = 40, -- Width of the side window

			keymaps = {
				close          = {}, -- No need, autocommands handle this better
				goto_location  = '<CR>',
				focus_location = 'o',
				hover_symbol   = '<C-Space>',
				preview_symbol = 'K',
				rename_symbol  = { 'r', 'R' },
				code_actions   = 'a',
			},

			symbols = {
				File          = { icon = '',    hl = 'TSURI' },
				Module        = { icon = '',    hl = 'TSNamespace' },
				Namespace     = { icon = '',    hl = 'TSNamespace' },
				Package       = { icon = '',    hl = 'TSNamespace' },
				Class         = { icon = '𝓒',    hl = 'TSType' },
				Method        = { icon = 'ƒ',    hl = 'TSMethod' },
				Property      = { icon = '',    hl = 'TSMethod' },
				Field         = { icon = '',    hl = 'TSField' },
				Constructor   = { icon = '',    hl = 'TSConstructor' },
				Enum          = { icon = 'ℰ',    hl = 'TSType' },
				Interface     = { icon = 'ﰮ',    hl = 'TSType' },
				Function      = { icon = 'ƒ',    hl = 'TSFunction' },
				Variable      = { icon = '',    hl = 'TSConstant' },
				Constant      = { icon = '',    hl = 'TSConstant' },
				String        = { icon = '𝓐',    hl = 'TSString' },
				Number        = { icon = '#',    hl = 'TSNumber' },
				Boolean       = { icon = '⊨',    hl = 'TSBoolean' },
				Array         = { icon = '',    hl = 'TSConstant' },
				Object        = { icon = '⦿',    hl = 'TSType' },
				Key           = { icon = '🔐',   hl = 'TSType' },
				Null          = { icon = 'NULL', hl = 'TSType' },
				EnumMember    = { icon = '',    hl = 'TSField' },
				Struct        = { icon = '𝓢',    hl = 'TSType' },
				Event         = { icon = '🗲',    hl = 'TSType' },
				Operator      = { icon = '+',    hl = 'TSOperator' },
				TypeParameter = { icon = '𝙏',    hl = 'TSParameter' },
			},
		})
	end,
}

-- vim: set fdm=marker fdl=0:
