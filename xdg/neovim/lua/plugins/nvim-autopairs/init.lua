return {
	'windwp/nvim-autopairs',

	event = {
		'InsertEnter',
	},

	dependencies = {
		'hrsh7th/nvim-cmp',
		'nvim-treesitter/nvim-treesitter',
	},

	config = function()
		require('plugins.nvim-autopairs.config').setup()
		require('plugins.nvim-autopairs.rules').setup()
	end,
}
