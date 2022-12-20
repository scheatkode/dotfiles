return {
	'williamboman/mason-lspconfig.nvim',

	dependencies = {
		'williamboman/mason.nvim',
	},

	config = function()
		require('mason-lspconfig').setup()
	end,
}
