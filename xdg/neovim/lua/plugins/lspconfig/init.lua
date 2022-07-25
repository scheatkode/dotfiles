return { 'neovim/nvim-lspconfig', opt = true,
	cmd    = {
		'LspStatus',
		'LspStart',
		'LspInfo',
	},
	event  = { 'BufReadPre' },
	module = { 'lspconfig' },

	config = function()
		require('mason').setup()
		require('plugins.lspconfig.config')
	end,
}
