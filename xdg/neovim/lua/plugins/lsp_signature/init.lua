return {
	'ray-x/lsp_signature.nvim',

	dependencies = {
		'neovim/nvim-lspconfig',
	},

	event = {
		'InsertEnter',
	},

	config = function()
		require('plugins.lsp_signature.config').setup()
	end,
}