return {
	setup = function()
		local dapui = require('dapui')

		vim.keymap.set('n', '<leader>df', dapui.float_element, { desc = 'Toggle debugging visuals' })
		vim.keymap.set('n', '<leader>dv', dapui.toggle, { desc = 'Toggle debugging visuals' })
		vim.keymap.set({ 'n', 'v' }, '<leader>de', dapui.eval, { desc = 'Evaluate' })
	end,
}
