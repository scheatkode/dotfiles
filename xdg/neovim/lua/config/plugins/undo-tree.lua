require('sol.vim').apply_keymaps({
   {'n', '<leader>u', '<cmd>UndotreeToggle<CR>', {silent = true, noremap = true}},
})

--- whichkey setup

local has_whichkey, whichkey = pcall(require, 'which-key')

if not has_whichkey then
   return has_whichkey
end

whichkey.register({
   ['<leader>u'] = {
      name = 'Undo tree show',
   },
})
