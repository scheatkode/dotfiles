return {
	'Wansmer/treesj',

	keys = {
		'gS',
		'gJ',
	},

	config = function()
		require('plugins.treesj.config').setup()
		require('plugins.treesj.keys').setup()
	end,
}
