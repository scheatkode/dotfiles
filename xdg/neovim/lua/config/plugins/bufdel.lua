--- nvim-autopairs configuration

local has_bufdel, bufdel = pcall(require, 'bufdel')

if not has_bufdel then
   print('‼ Tried loading bufdel ... unsuccessfully.')
   return has_bufdel
end

bufdel.setup({
   next = 'alternate'
})

--- keymaps

require('sol.vim').apply_keymaps({
   {'n', '<leader>bk', '<Cmd>BufDel<CR>',  {silent= true, noremap = true}},
   {'n', '<leader>bK', '<Cmd>BufDel!<CR>', {silent= true, noremap = true}},
})
