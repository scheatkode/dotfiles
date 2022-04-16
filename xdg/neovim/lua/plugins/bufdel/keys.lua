local function setup ()
   vim.keymap.set('n', '<leader>bk', '<cmd>BufDel<CR>',  {desc = 'Delete current buffer, keeping layout'})
   vim.keymap.set('n', '<leader>bK', '<cmd>BufDel!<CR>', {desc = 'Force delete current buffer, keeping layout'})
end

return {
   setup = setup
}
