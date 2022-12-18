return {
	'nvim-treesitter/nvim-treesitter',

	as = 'treesitter',

	opt = true,
	cmd = {
		'TSUpdate',
		'TSInstall',
	},
	event = {
		'BufEnter',
	},

	requires = {
		{ 'nvim-treesitter/nvim-treesitter-textobjects' }, -- "smart" textobjects
		{ 'JoosepAlviste/nvim-ts-context-commentstring' },
	},

	run = function()
		require('nvim-treesitter.install').update({ with_sync = true })
	end,

	config = function()
		require('plugins.treesitter.config').setup()
	end,
}
