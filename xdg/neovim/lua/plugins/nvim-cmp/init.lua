return {
	'hrsh7th/nvim-cmp',

	event = 'InsertEnter',

	dependencies = {
		'L3MON4D3/LuaSnip',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-path',
		'neovim/nvim-lspconfig',
		'saadparwaiz1/cmp_luasnip',
	},

	config = function()
		require('plugins.nvim-cmp.config').setup()
	end,
}
