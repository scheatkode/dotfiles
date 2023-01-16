return {
	'nvim-neorg/neorg',

	ft = 'norg',

	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-treesitter/nvim-treesitter',
	},

	run = ':Neorg sync-parsers',

	config = function()
		require('plugins.neorg.config').setup()
	end,
}
