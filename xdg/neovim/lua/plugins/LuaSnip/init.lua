return {
	'L3MON4D3/LuaSnip',

	-- dependencies = { 'rafamadriz/friendly-snippets' },

	config = function()
		require('plugins.LuaSnip.config').setup()
		require('plugins.LuaSnip.keys').setup()
	end
}
