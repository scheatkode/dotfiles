return {
	'tamago324/lir.nvim',

	opt = true,

	keys = {
		'-',
	},

	config = function()
		require('plugins.explorer.config').setup()
		require('plugins.explorer.keys').setup()
	end
}
