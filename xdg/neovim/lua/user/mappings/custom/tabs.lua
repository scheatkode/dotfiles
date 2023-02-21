return {
	---tab operations
	setup = function()
		vim.keymap.set('n', '<leader>tl', '<cmd>tabs<CR>',        { desc = 'List tabs' })
		vim.keymap.set('n', '<leader>tN', '<cmd>tabnew<CR>',      { desc = 'New tab' })
		vim.keymap.set('n', '<leader>tn', '<cmd>tabnext<CR>',     { desc = 'Next tab' })
		vim.keymap.set('n', '<leader>tp', '<cmd>tabprevious<CR>', { desc = 'Prevous tab' })
		vim.keymap.set('n', '<leader>tq', '<cmd>tabclose<CR>',    { desc = 'Quit/Close tab' })

		vim.keymap.set('n', '<leader>t1', '<cmd>tab 1<CR>', { desc = 'Go to tab 1' })
		vim.keymap.set('n', '<leader>t2', '<cmd>tab 2<CR>', { desc = 'Go to tab 2' })
		vim.keymap.set('n', '<leader>t3', '<cmd>tab 3<CR>', { desc = 'Go to tab 3' })
		vim.keymap.set('n', '<leader>t4', '<cmd>tab 4<CR>', { desc = 'Go to tab 4' })
		vim.keymap.set('n', '<leader>t5', '<cmd>tab 5<CR>', { desc = 'Go to tab 5' })
		vim.keymap.set('n', '<leader>t6', '<cmd>tab 6<CR>', { desc = 'Go to tab 6' })
		vim.keymap.set('n', '<leader>t7', '<cmd>tab 7<CR>', { desc = 'Go to tab 7' })
		vim.keymap.set('n', '<leader>t8', '<cmd>tab 8<CR>', { desc = 'Go to tab 8' })
		vim.keymap.set('n', '<leader>t9', '<cmd>tab 9<CR>', { desc = 'Go to tab 9' })
	end
}
