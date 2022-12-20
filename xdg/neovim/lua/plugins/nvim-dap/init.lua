return {
	'mfussenegger/nvim-dap',

	keys = {
		'<leader>d',
		'<leader>dC',
		'<leader>dD',
		'<leader>dO',
		'<leader>dP',
		'<leader>dQ',
		'<leader>db',
		'<leader>dc',
		'<leader>dd',
		'<leader>di',
		'<leader>dl',
		'<leader>do',
		'<leader>dp',
		'<leader>dq',
		'<leader>dr',
		'<leader>du',
	},

	config = function()
		require('plugins.nvim-dap.config').setup()
		require('plugins.nvim-dap.keys').setup()
	end,
}
