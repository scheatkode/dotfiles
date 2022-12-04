return {
	'j-hui/fidget.nvim',

	opt   = true,
	after = 'mason.nvim',

	config = function()
		require('fidget').setup({
			text = {
				spinner = 'dots',
			}
		})
	end
}
