local function setup ()
   vim.keymap.set('n', '<leader>co', '<cmd>SymbolsOutline<CR>', {desc = 'Toggle code outline window'})
end

return {
   setup = setup
}
