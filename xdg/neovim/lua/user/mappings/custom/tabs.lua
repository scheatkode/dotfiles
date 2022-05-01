return {
	---tab operations
	setup = function()
		vim.keymap.set('n', '<leader>tl', '<cmd>tabs<CR>',        { desc = 'List tabs' })
		vim.keymap.set('n', '<leader>tN', '<cmd>tabnew<CR>',      { desc = 'New tab' })
		vim.keymap.set('n', '<leader>tn', '<cmd>tabnext<CR>',     { desc = 'Next tab' })
		vim.keymap.set('n', '<leader>tp', '<cmd>tabprevious<CR>', { desc = 'Prevous tab' })
		vim.keymap.set('n', '<leader>tq', '<cmd>tabclose<CR>',    { desc = 'Quit/Close tab' })
	end
}
