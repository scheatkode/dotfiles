return {
	'rcarriga/nvim-dap-ui',

	keys = {
		'<leader>de',
		'<leader>dv',
	},

	config = function()
		require('plugins.nvim-dap-ui.config').setup()
		require('plugins.nvim-dap-ui.keys').setup()
	end,
}
