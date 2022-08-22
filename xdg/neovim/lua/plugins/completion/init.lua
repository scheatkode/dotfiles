return {
	'hrsh7th/nvim-cmp',

	opt   = true,
	event = { 'InsertEnter' },
	wants = {
		'nvim-lspconfig',
		'luasnip',
	},

	requires = {
		'neovim/nvim-lspconfig',
	},

	config = function()
		require('plugins.completion.config')
	end,
}
