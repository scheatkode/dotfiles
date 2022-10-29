return {
	'kevinhwang91/nvim-bqf',

	opt = true,
	ft  = 'qf',

	config = function()
		require('plugins.quickfix.config').setup()
	end,
}
