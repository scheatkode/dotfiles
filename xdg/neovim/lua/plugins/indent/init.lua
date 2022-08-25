return {
	'lukas-reineke/indent-blankline.nvim',

	opt     = false,
	event   = { 'BufReadPre', },
	modules = { 'indent_blankline' },

	config = function()
		require('plugins.indent.config')
	end,
}
