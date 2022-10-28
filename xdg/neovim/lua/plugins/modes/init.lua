return {
	'anuvyklack/hydra.nvim',

	opt  = true,
	keys = {
		'z',
		'<C-w>',
		'<leader>D',
	},

	config = function()
		require('plugins.modes.config').setup()
	end,
}
