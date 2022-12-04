return {
	'williamboman/mason-lspconfig.nvim',

	opt = true,

	module = { 'mason-lspconfig' },
	after  = { 'mason.nvim' },

	config = function()
		require('mason-lspconfig').setup()
	end
}
