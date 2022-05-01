return {
	---auto correct me please
	setup = function()
		vim.keymap.set('i', '!+', '!=', { nowait = true, silent = true })
		vim.keymap.set('i', '_>', '->', { nowait = true, silent = true })
		vim.keymap.set('i', '+>', '=>', { nowait = true, silent = true })
	end
}
