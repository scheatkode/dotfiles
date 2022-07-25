return {
	'anuvyklack/hydra.nvim',

	opt = true,

	keys = {
		'z',
	},

	config = function()
		require('plugins.modes.config').setup()
	end,
}
