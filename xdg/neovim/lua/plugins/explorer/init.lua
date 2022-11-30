return {

	'nvim-neo-tree/neo-tree.nvim',
	branch = 'v2.x',

	opt = true,

	cmd  = 'Neotree',
	keys = {
		'<F1>',
		'-',
	},

	wants = {
		'nvim-web-devicons',
		'nui.nvim',
	},

	requires = {
		'nvim-lua/plenary.nvim',
		'kyazdani42/nvim-web-devicons',
		'MunifTanjim/nui.nvim',
	},

	setup = function()
		vim.g.neo_tree_remove_legacy_commands = 1
	end,

	config = function()
		require('plugins.explorer.config').setup()
		require('plugins.explorer.keys').setup()
	end,

}
