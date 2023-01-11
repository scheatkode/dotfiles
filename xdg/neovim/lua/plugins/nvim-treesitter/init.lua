return {
	'nvim-treesitter/nvim-treesitter',

	dependencies = {
		{ 'JoosepAlviste/nvim-ts-context-commentstring' },
		{ 'nvim-treesitter/nvim-treesitter-textobjects' },
		{ 'nvim-treesitter/playground', cmd = 'TSPlaygroundToggle' },
	},

	event = {
		'FileType',
	},

	build = ':TSUpdate',

	config = function()
		require('plugins.nvim-treesitter.config').setup()
	end,
}
