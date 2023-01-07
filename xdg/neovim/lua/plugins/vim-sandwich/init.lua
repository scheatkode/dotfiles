return {
	'machakann/vim-sandwich',

	keys = {
		{ '<leader>sa',  mode = { 'n', 'x' } },
		{ '<leader>ts',  mode = { 'n', 'x' } },
		{ '<leader>tsa', mode = { 'n', 'x' } },
		{ '<leader>tsc', mode = { 'n', 'x' } },
		{ '<leader>tsC', mode = { 'n', 'x' } },
		{ '<leader>tsd', mode = { 'n', 'x' } },
		{ '<leader>tsD', mode = { 'n', 'x' } },
	},

	init = function()
		vim.g.sandwich_no_default_key_mappings = 1
	end,

	config = function()
		require('plugins.vim-sandwich.keys').setup()
	end,
}
