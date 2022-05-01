return {
	---be consistent with shell mappings
	setup = function()
		vim.keymap.set('i', '<M-d>', '<Esc>ldwi', { nowait = true })
	end
}
