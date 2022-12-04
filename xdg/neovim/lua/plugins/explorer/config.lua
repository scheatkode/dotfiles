return {
	setup = function()
		local lazy = require('lazy.on_member_call')
		local actions = lazy('plugins.explorer.actions')

		local defaults  = lazy('lir.actions')
		local clipboard = lazy('lir.clipboard.actions')
		local marks     = lazy('lir.mark.actions')

		local lir = require('lir')

		lir.setup({
			ignore = {},

			show_hidden_files = false,

			mappings = {
				['<CR>']  = defaults.edit,
				['o']     = defaults.edit,
				['<C-s>'] = defaults.split,
				['<C-v>'] = defaults.vsplit,

				['-'] = defaults.up,

				['q']     = defaults.quit,
				['<Esc>'] = defaults.quit,
				['<C-c>'] = defaults.quit,

				['R'] = defaults.reload,

				['r'] = actions.rename,
				['@'] = defaults.cd,
				['X'] = defaults.delete,

				['a'] = actions.new_node,

				['Y'] = defaults.yank_path,
				['H'] = defaults.toggle_show_hidden,

				['<Tab>'] = marks.toggle_mark,

				['yy'] = clipboard.copy,
				['dd'] = clipboard.cut,
				['p']  = clipboard.paste,

				['.'] = actions.populate_command,
			},

			float = {
				winblend = 0,

				win_opts = function()
					return {
						border = 'none',
					}
				end,

				curdir_window = {
					enable            = true,
					highlight_dirname = true,
				}
			},
		})
	end
}
