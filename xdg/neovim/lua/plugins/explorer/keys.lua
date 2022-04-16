local function setup ()
   vim.keymap.set('n', '<F1>', '<cmd>NvimTreeToggle<CR>', {desc = 'Toggle file explorer'})
end

return {
   setup = setup
}
