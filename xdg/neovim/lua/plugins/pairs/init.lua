return { 'windwp/nvim-autopairs', opt = true,
	event = { 'InsertEnter' },

	wants    = { 'nvim-cmp' },
	requires = { 'hrsh7th/nvim-cmp' },

	config = function()
		require('plugins.pairs.config').setup()
	end,
}
