return {
	'j-hui/fidget.nvim',

	opt   = true,
	after = 'nvim-lspconfig',

	config = function()
		require('fidget').setup({
			text = {
				spinner = 'dots',
			}
		})
	end
}
