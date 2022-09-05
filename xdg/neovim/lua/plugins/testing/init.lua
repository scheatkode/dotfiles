return {
	'nvim-neotest/neotest',

	opt = true,

	keys = {
		'<leader>ct'
	},

	module = {
		'neotest',
	},

	requires = {
		'nvim-neotest/neotest-plenary',
	},

	wants = {
		'neotest-plenary',
	},

	config = function()
		require('plugins.testing.config').setup()
		require('plugins.testing.keys').setup()
	end
}
