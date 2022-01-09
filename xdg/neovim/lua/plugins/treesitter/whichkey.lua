local has_whichkey, whichkey = pcall(require, 'which-key')

if not has_whichkey then
   return has_whichkey
end

whichkey.register({
   ['<leader>c'] = {
      name = '+code',

      -- g = {
      --    name = '+generate',

      --    d = 'Generate documentation',
      -- },

      p = {
         name = '+parameter',

         s = {'Swap next parameter'},
         S = {'Swap previous parameter'},
      },
   }
})

-- vim: set ft=lua fdm=marker fdl=0:
