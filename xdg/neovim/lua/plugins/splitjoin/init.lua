return {
	'Wansmer/treesj',

	opt = true,

	keys = {
		{ 'n', 'gS' },
		{ 'n', 'gJ' },
	},

	config = function()
		require('plugins.splitjoin.config').setup()
		require('plugins.splitjoin.keys').setup()
	end
}
