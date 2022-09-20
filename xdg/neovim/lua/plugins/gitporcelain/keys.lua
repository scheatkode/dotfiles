return {
	setup = function()
		vim.keymap.set('n', '<leader>gg', '<cmd>Neogit<CR>', { desc = 'Open git porcelain' })
	end
}
