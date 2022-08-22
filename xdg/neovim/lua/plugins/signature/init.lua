return {
	'ray-x/lsp_signature.nvim',

	opt    = true,
	event  = { 'InsertEnter' },
	module = { 'lsp_signature' },

	wants    = { 'nvim-lspconfig' },
	requires = { 'neovim/nvim-lspconfig' },

	config = function()
		require('plugins.signature.config').setup()
	end,
}
