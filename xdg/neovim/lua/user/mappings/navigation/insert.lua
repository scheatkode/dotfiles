return {
	---insert-mode quick navigation
	setup = function()
		vim.keymap.set('i', '<M-h>', '<Left>')
		vim.keymap.set('i', '<M-l>', '<Right>')
	end
}
