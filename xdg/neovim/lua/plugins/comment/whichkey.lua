local has_whichkey, whichkey = pcall(require, 'which-key')

if not has_whichkey then
   return has_whichkey
end

whichkey.register({
   ['<leader>/'] = {'Comment line'},
})

whichkey.register({
   ['<leader>/'] = {'Comment line'},
}, {
   mode = 'v'
})

whichkey.register({
   ['<leader>c'] = {
      name = '+code',

      c = {
         name = '+comment',

         c = {'Comment line'},
         m = {'Comment motion'},

         i = {
            name = '+increase',

            c = {'Increase commenting level for line'},
            m = {'Increase commenting level for motion'},
         },

         d = {
            name = '+decrease',

            c = {'Decrease commenting level for line'},
            m = {'Decrease commenting level for motion'},
         },
      },
   },
})

whichkey.register({
   ['<leader>c'] = {
      name = '+code',

      c = {
         name = '+comment',

         c = {'Comment selection'},
         i = {'Increase commenting level'},
         d = {'Decrease commenting level'},
      },
   },
}, {
   mode = 'v',
})
