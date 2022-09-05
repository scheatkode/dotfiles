return {
	setup = function()
		vim.opt.list       = true -- Enable visual queues for invisible characters
		vim.opt.joinspaces = false -- Whoever thought this was a good idea ?

		vim.opt.fillchars = {
			diff      = '░',
			eob       = '~', -- keep showing me `~` at the end of the buffer
			fold      = ' ',
			foldclose = '▸',
			foldopen  = '▾',
			foldsep   = '│',
			msgsep    = '‾',
			vert      = '▕',
		}

		vim.opt.listchars = {
			eol        = nil,
			extends    = '›',
			multispace = '⋅',
			nbsp       = '␣',
			precedes   = '‹',
			tab        = '» ',
			trail      = '•',
		}

		vim.opt.backspace = { -- Backspace acts as it should
			'eol',
			'start',
			'indent',
		}
	end
}
