return {
	---remove search highlight on `<Esc>`
	setup = function()
   	-- vim.keymap.set('n', '<Esc>', '<cmd>let @/=""<CR>', {remap = true, silent = true})
		vim.keymap.set('n', '<Esc>', '<cmd>:nohlsearch<CR>', { remap = true, silent = true })
	end
}
