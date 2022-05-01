return {
	---shame on you
	setup = function()
		vim.keymap.set('n', '<leader>qq', '<cmd>quitall<CR>',  { desc = 'Quit Neovim' })
		vim.keymap.set('n', '<leader>qQ', '<cmd>quitall!<CR>', { desc = 'Quit Neovim forcefully' })
		vim.keymap.set('n', '<leader>QQ', '<cmd>quitall!<CR>', { desc = 'Quit Neovim forcefully' })
	end
}
