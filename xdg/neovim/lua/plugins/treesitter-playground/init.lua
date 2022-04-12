return {
	'nvim-treesitter/playground',

	opt = true,

	cmd = {
		'TSPlaygroundToggle'
	},

	requires = {
		'nvim-treesitter/nvim-treesitter',
	},

	wants = {
		'treesitter',
	},
}
