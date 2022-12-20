return {
	'neovim/nvim-lspconfig',

	cmd = {
		'LspStatus',
		'LspStart',
		'LspInfo',
	},
	event = {
		'FileType',
	},

	dependencies = {
		'j-hui/fidget.nvim',
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
	},

	config = function()
		require('plugins.nvim-lspconfig.config')
	end,
}
