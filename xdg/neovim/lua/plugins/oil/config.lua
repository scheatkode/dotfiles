return {
	setup = function()
		local oil = require('oil')

		local function populate_command()
			local entry   = oil.get_cursor_entry()
			local command = ':<C-u> ' .. entry.name .. '<Home>'
			local keys    =
				vim.api.nvim_replace_termcodes(command, true, true, true)

			vim.api.nvim_feedkeys(keys, 'nt', false)
		end

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

				['<CR>'] = 'actions.select',
				['<Esc>'] = 'actions.close',
				['<C-c>'] = 'actions.close',
				['q'] = 'actions.close',

				['<C-v>'] = 'actions.select_vsplit',
				['<C-s>'] = 'actions.select_split',
				['<C-p>'] = 'actions.preview',
				['<C-l>'] = 'actions.refresh',

				['.'] = populate_command,

				['-'] = 'actions.parent',
				['_'] = 'actions.open_cwd',
				['`'] = 'actions.cd',
				['~'] = 'actions.tcd',
				['H'] = 'actions.toggle_hidden',
			},
		})
	end,
}
