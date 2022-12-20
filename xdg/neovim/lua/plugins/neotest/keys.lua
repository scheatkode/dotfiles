return {
	setup = function()
		vim.keymap.set('n', '<leader>ct', require('neotest').run.run, {
			desc = 'Run nearest test',
		})
	end,
}
