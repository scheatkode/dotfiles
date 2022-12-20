return {
	setup = function()
		require('dapui').setup({
			icons = {
				expanded  = '▾',
				collapsed = '▸',
			},

			mappings = {
				expand = { '<Tab>' },
				open   = { 'o', '<CR>' },
				remove = 'd',
				edit   = 'e',
				repl   = 'r',
				toggle = 't',
			},

			layouts = {
				{
					elements = {
						{ id = 'scopes',      size = 0.25 },
						{ id = 'breakpoints', size = 0.25 },
						{ id = 'stacks',      size = 0.25 },
						{ id = 'watches',     size = 0.25 },
					},
					position = 'left',
					size     = 40,
				},
				{
					elements = { 'repl' },
					position = 'bottom',
					size     = 10,
				},
			},

			floating = {
				max_height = nil, -- These can be integers or a float between 0 and 1.
				max_width  = nil, -- Floats will be treated as percentage of your screen.
				border     = 'rounded',
				mappings   = {
					close = { 'q', '<Esc>' },
				},
			},

			windows = {
				indent = 1,
			},

			render = {
				max_type_length = nil,
			},
		})
	end,
}
