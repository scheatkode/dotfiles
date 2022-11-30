return {
	'L3MON4D3/LuaSnip',

	opt = true,

	as       = 'luasnip',
	module   = 'luasnip',
	requires = { 'rafamadriz/friendly-snippets' },

	config = function()
		require('plugins.snippets.keys').setup()
	end
}
