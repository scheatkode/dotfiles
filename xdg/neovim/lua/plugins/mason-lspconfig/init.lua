return {
	'williamboman/mason-lspconfig.nvim',

	opt = true,

	module = { 'mason-lspconfig' },

	config = function()
		require('mason-lspconfig').setup()
	end
}
