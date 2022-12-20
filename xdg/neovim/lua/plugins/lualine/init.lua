return {
	'nvim-lualine/lualine.nvim',

	dependencies = {
		'kyazdani42/nvim-web-devicons',
	},

	event = {
		'VimEnter',
	},

	config = function()
		require('plugins.lualine.config').setup()
	end,
}
