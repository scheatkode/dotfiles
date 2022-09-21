return {
	'anuvyklack/hydra.nvim',

	opt  = true,
	keys = {
		'z',
		'<C-w>',
	},

	config = function()
		require('plugins.modes.config').setup()
	end,
}
