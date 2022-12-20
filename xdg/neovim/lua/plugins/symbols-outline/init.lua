return {
	'simrat39/symbols-outline.nvim',

	dependencies = {
		'neovim/nvim-lspconfig',
	},

	cmd = {
		'SymbolsOutline',
	},
	keys = {
		'<leader>co',
	},

	config = function()
		require('plugins.symbols-outline.config').setup()
		require('plugins.symbols-outline.keys').setup()
	end,
}
