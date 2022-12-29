return {
	'L3MON4D3/LuaSnip',

	config = function()
		require('plugins.LuaSnip.config').setup()
		require('plugins.LuaSnip.keys').setup()
	end,
}
