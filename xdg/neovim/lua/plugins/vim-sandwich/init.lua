return {
	'machakann/vim-sandwich',

	keys = {
		'<leader>sa',
		'<leader>ts',
		'<leader>tsa',
		'<leader>tsc',
		'<leader>tsC',
		'<leader>tsd',
		'<leader>tsD',
		'<leader>ts',
		'<leader>tsa',
	},

	init = function()
		vim.g.sandwich_no_default_key_mappings = 1
	end,

	config = function()
		require('plugins.vim-sandwich.keys').setup()
	end,
}
