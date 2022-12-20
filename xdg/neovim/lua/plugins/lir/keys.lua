return {
	setup = function()
		vim.keymap.set('n', '-', require('lir.float').init, {
			desc = 'Toggle file explorer',
		})
	end,
}
