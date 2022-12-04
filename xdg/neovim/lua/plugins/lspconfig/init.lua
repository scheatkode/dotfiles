return { 'neovim/nvim-lspconfig', opt = true,
	cmd    = {
		'LspStatus',
		'LspStart',
		'LspInfo',
	},
	event  = { 'BufReadPre' },
	module = { 'lspconfig' },
	wants  = { 'mason.nvim' },

	config = function()
		require('plugins.lspconfig.config')
	end,
}
