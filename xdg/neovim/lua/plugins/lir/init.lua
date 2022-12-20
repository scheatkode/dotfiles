return {
	'tamago324/lir.nvim',

	keys = {
		'-',
	},

	dependencies = {
		'nvim-lua/plenary.nvim',
		'tamago324/lir-git-status.nvim',
	},

	config = function()
		require('plugins.lir.config').setup()
		require('plugins.lir.keys').setup()
	end,
}
