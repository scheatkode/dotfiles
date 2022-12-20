return {
	'numToStr/Comment.nvim',

	keys = {
		'<leader>/',
		'gcc',
		'gcb',
		'gco',
		'gcO',
		'gcA',
	},

	dependencies = {
		'JoosepAlviste/nvim-ts-context-commentstring',
	},

	config = function()
		require('plugins.Comment.config').setup()
		require('plugins.Comment.keys').setup()
	end,
}
