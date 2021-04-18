--- easy-align configuration

require('sol.vim').apply_keymaps({
   {'n', '<leader>ta', '<Plug>(EasyAlign)', {}},
   {'x', '<leader>ta', '<Plug>(EasyAlign)', {}},
})

--- whichkey configuration

local ok, whichkey = pcall(require, 'whichkey_setup')

if not ok then
   return ok
end

whichkey.register_keymap('leader', {
   t = {
      name = '+text',

      a = 'Align text',
   },
}, {
   noremap = false,
})

whichkey.register_keymap('leader', {
   t = {
      name = '+text',

      a = 'Align text',
   },
}, {
   mode    = 'v',
   noremap = false,
})

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set sw=3 ts=3 sts=3 et tw=80
