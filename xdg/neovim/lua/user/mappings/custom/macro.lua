return {
	---edit macros
	---https://github.com/mhinz/vim-galore#quickly-edit-your-macros
	setup = function()
		vim.keymap.set('n', '<leader>m', ":<C-u><C-r><C-r>='let @' . v:register . ' = ' . string(getreg(v:register))<CR><C-f><left>", { desc = 'Edit macro' })
	end
}
