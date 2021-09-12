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
