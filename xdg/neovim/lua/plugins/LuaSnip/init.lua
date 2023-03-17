return {
	'L3MON4D3/LuaSnip',

	keys = {
		{ '<M-CR>', mode = { 'i' } },
	},

	config = function()
		require('plugins.LuaSnip.config').setup()
		require('plugins.LuaSnip.keys').setup()
	end,
}
