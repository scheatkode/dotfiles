return {
	---visual 'shorthand'
	setup = function()
		vim.keymap.set('n', 'vv', 'V',      { desc = 'visual line shorthand' })
		vim.keymap.set('n', 'vvv', '<C-v>', { desc = 'visual block shorthand' })
	end
}
