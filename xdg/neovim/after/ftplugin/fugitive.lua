vim.keymap.set('n', '<Tab>', '<Plug>fugitive:=', {
	buffer = true,
	desc   = 'Toggle an inline diff of the file under the cursor.',
})

vim.keymap.set('n', '<leader>gp', '<cmd>G push<CR>', {
	buffer = true,
	desc   = 'Push the local commits.',
})

vim.keymap.set('n', '<leader>gc', '<cmd>vertical G commit<CR>', {
	buffer = true,
	desc   = 'Create a new commit.',
})

vim.keymap.set('n', 'cnc', '<cmd>G commit --no-verify<CR>', {
	buffer = true,
	desc   = 'Create a new commit without running git hooks.'
})

vim.keymap.set('n', 'cne', '<cmd>G commit --amend --no-edit --no-verify<CR>', {
	buffer = true,
	desc   = 'Create a new commit without running git hooks.'
})
