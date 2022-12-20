return {
	'j-hui/fidget.nvim',

	dependencies = {
		'neovim/nvim-lspconfig',
	},

	config = function()
		require('fidget').setup({
			text = { spinner = 'dots' },
		})
	end,
}
