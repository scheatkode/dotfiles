return {
	'jose-elias-alvarez/null-ls.nvim',

	opt    = true,
	ft     = require('plugins.lint.filetypes'),
	module = 'null-ls',

	requires = {
		'neovim/nvim-lspconfig',
		'nvim-lua/plenary.nvim',
	},

	config = function()
		require('plugins.lint.config')
	end,
}
