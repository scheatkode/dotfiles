local function setup ()
   vim.keymap.set('n', '<leader>ctq', '<cmd>TodoQuickFix<CR>',  {desc = 'Show todos in quickfix window'})
   vim.keymap.set('n', '<leader>ctd', '<cmd>TodoTrouble<CR>',   {desc = 'Show todos in diagnostics buffer'})
   vim.keymap.set('n', '<leader>ctt', '<cmd>TodoTelescope<CR>', {desc = 'Show todos in Telescope'})
   vim.keymap.set('n', '<leader>st',  '<cmd>TodoTelescope<CR>', {desc = 'Search todos'})
end

return {
   setup = setup
}
