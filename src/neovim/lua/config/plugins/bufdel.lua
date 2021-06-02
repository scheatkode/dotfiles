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

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set ft=lua sw=3 ts=3 sts=3 et tw=78:
