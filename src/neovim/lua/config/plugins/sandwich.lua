--- sandwich configuration

require('sol.vim').apply_keymaps({
   {'n', '<leader>tsd',  '<Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)',  {}},
   {'n', '<leader>tsD', '<Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)',   {}},
   {'n', '<leader>tsc',  '<Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)', {}},
   {'n', '<leader>tsC',  '<Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)',  {}},
   {'n', '<leader>tsa',  '<Plug>(operator-sandwich-add)',                                                                            {}},
   {'x', '<leader>tsa',  '<Plug>(operator-sandwich-add)',                                                                            {}},

   {'x', 'is', '<Plug>(textobj-sandwich-query-i)', {}},
   {'x', 'as', '<Plug>(textobj-sandwich-query-a)', {}},
   {'o', 'is', '<Plug>(textobj-sandwich-query-i)', {}},
   {'o', 'as', '<Plug>(textobj-sandwich-query-a)', {}},

   {'x', 'iS', '<Plug>(textobj-sandwich-auto-i)', {}},
   {'x', 'aS', '<Plug>(textobj-sandwich-auto-a)', {}},
   {'o', 'iS', '<Plug>(textobj-sandwich-auto-i)', {}},
   {'o', 'aS', '<Plug>(textobj-sandwich-auto-a)', {}},

   {'x', 'im', '<Plug>(textobj-sandwich-literal-query-i)', {}},
   {'x', 'am', '<Plug>(textobj-sandwich-literal-query-a)', {}},
   {'o', 'im', '<Plug>(textobj-sandwich-literal-query-i)', {}},
   {'o', 'am', '<Plug>(textobj-sandwich-literal-query-a)', {}},
})

--- whichkey configuration

local ok, whichkey = pcall(require, 'whichkey_setup')

if not ok then
   return ok
end

-- normal mode

whichkey.register_keymap('leader', {
   t = {
      name = '+text',

      s = {
         name = '+surround',

         C = 'Change surrounding character automatically',
         D = 'Delete surrounding character automatically',
         a = 'Add surrounding character',
         c = 'Change surrounding character',
         d = 'Delete surrounding character',
      },
   },
})

-- visual mode

whichkey.register_keymap('leader', {
   i = {
      name = '+inner',

      S = 'Select inside surrounding character automatically',
      m = 'Select inside surrounding character literally',
      s = 'Select inside surrounding character',
   },

   a = {
      name = '+outer',

      S = 'Select outside surrounding character automatically',
      m = 'Select outside surrounding character literally',
      s = 'Select outside surrounding character',
   }
}, {
   mode = 'v',
})

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set ft=lua sw=3 ts=3 sts=3 et tw=78:
