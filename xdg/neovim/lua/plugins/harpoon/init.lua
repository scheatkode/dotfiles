return {
	'ThePrimeagen/harpoon',

	opt = true,

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
		require('harpoon').setup()
		require('plugins.harpoon.keys').setup()
	end
}
