--- easy-align configuration

require('sol.vim').apply_keymaps({
   {'n', '<leader>ta', '<Plug>(EasyAlign)', {}},
   {'x', '<leader>ta', '<Plug>(EasyAlign)', {}},
})

--- whichkey configuration

local has_whichkey, whichkey = pcall(require, 'which-key')

if not has_whichkey then
   return has_whichkey
end

whichkey.register({
   ['<leader>t'] = {
      name = '+text',

      a = {'Align text'},
   },
})

whichkey.register({
   ['<leader>t'] = {
      name = '+text',

      a = {'Align text'},
   },
}, {
   mode    = 'v',
   noremap = false,
})

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set ft=lua sw=3 ts=3 sts=3 et tw=78:
