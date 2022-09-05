return {
	'nvim-neorg/neorg',

	opt = true,
	ft = 'norg',

	requires = {
		'nvim-lua/plenary.nvim',
	},

	wants = {
		'plenary.nvim',
	},

	config = function()
		require('plugins.notes.config')
	end,
}
