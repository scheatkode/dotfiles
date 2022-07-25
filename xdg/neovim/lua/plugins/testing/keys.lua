local function setup()
	local neotest = require('neotest')

	vim.keymap.set('n', '<leader>ct', neotest.run.run, { desc = 'Run nearest test' })
end

return {
	setup = setup
}
