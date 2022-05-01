return {
	---entire buffer text object
	setup = function()
		vim.keymap.set('x', 'ie', '<cmd>keepjumps normal! gg0oG$<cr>', { silent = true })
		vim.keymap.set('x', 'ae', '<cmd>keepjumps normal! gg0oG$<cr>', { silent = true })

		vim.keymap.set('o', 'ie', '<cmd>keepjumps normal! ggVG<cr>', { silent = true })
		vim.keymap.set('o', 'ae', '<cmd>keepjumps normal! ggVG<cr>', { silent = true })
	end
}
