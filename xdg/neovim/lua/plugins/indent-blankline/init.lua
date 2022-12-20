return {
	'lukas-reineke/indent-blankline.nvim',

	event = {
		'FileType',
	},

	config = function()
		require('plugins.indent-blankline.config').setup()
	end,
}
