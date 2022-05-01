return {
	---when modifier keys are redundant
	setup = function()
		vim.keymap.set('i', ',-', '<-',   { nowait = true, silent = true })
		vim.keymap.set('i', ';=', ':=',   { nowait = true, silent = true })
		vim.keymap.set('i', ';;', '::',   { nowait = true, silent = true })
		vim.keymap.set('i', ';//', '://', { nowait = true, silent = true })
	end
}
