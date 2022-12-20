return {
	'junegunn/vim-easy-align',

	cmd = {
		'EasyAlign',
	},
	keys = {
		'<leader>t',
		'<leader>ta',
		'<leader>tl',
		'<Plug>(EasyAlign)',
		'<Plug>(LiveEasyAlign)',
	},

	config = function()
		require('plugins.vim-easy-align.keys').setup()
	end,
}
