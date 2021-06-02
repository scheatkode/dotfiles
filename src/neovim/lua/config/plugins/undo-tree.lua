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

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set ft=lua sw=3 ts=3 sts=3 et tw=78:
