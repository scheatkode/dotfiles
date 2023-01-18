return {
	setup = function()
		local oil = require('oil')

		oil.setup({
			columns = {
				'permissions',
				'size',
				'mtime',
				'icon',
			},

			skip_confirm_for_simple_edits = true,

			float = {
				border = 'none',
			},

			use_default_keymaps = false,

			keymaps = {
				['g?'] = 'actions.show_help',

				['<CR>']  = 'actions.select',
				['<Esc>'] = 'actions.close',
				['<C-c>'] = 'actions.close',
				['q']     = 'actions.close',

				['<C-v>'] = 'actions.select_vsplit',
				['<C-s>'] = 'actions.select_split',
				['<C-p>'] = 'actions.preview',
				['<C-l>'] = 'actions.refresh',

				['.'] = 'actions.open_cmdline',

				['-'] = 'actions.parent',
				['_'] = 'actions.open_cwd',
				['`'] = 'actions.cd',
				['~'] = 'actions.tcd',
				['H'] = 'actions.toggle_hidden',
			},
		})
	end,
}
