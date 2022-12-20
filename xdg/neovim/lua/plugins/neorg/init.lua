return {
	'nvim-neorg/neorg',

	ft = 'norg',

	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-treesitter/nvim-treesitter',
	},

	config = function()
		require('plugins.notes.config').setup()
	end,
}
