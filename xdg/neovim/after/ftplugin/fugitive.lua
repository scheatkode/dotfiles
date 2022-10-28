vim.keymap.set({ 'n' }, '<Tab>', '<Plug>fugitive:=', { buffer = true })
vim.keymap.set({ 'n' }, '<leader>gp', '<cmd>G push<CR>', { buffer = true })
vim.keymap.set({ 'n' }, '<leader>cc', '<cmd>vert G commit<CR>', { buffer = true })
