return {
	'tpope/vim-fugitive',

	opt = true,

	cmd = {
		'G',
		'G%',
	},
	keys = {
		'<leader>gg',
	},

	config = function()
		vim.keymap.set('n', '<leader>gg', '<cmd>tab G<CR>', { desc = 'Open git fugitive' })
	end,
}
