return {
	---workaround for going up/down the jump list until tmux
	---supports `CSI u`.
	setup = function()
		vim.keymap.set('n', ']j', '<C-i>', { nowait = true })
		vim.keymap.set('n', '[j', '<C-o>', { nowait = true })
	end
}
