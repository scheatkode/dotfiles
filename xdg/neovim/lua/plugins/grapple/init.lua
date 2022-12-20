return {
	'cbochs/grapple.nvim',

	keys = {
		'<leader>h',
		'<leader>hh',
		'<leader>ha',
		'<leader>hn',
		'<leader>hp',
		'<leader>h1',
		'<leader>h2',
		'<leader>h3',
		'<leader>h4',
		'<leader>h5',
		'<leader>h6',
		'<leader>h7',
		'<leader>h8',
		'<leader>h9',
	},

	config = function()
		require('plugins.grapple.config').setup()
		require('plugins.grapple.keys').setup()
	end,
}
