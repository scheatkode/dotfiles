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

	build = function()
		require('nvim-treesitter.install').update({ with_sync = true })
	end,

	config = function()
		require('plugins.nvim-treesitter.config').setup()
	end,
}
