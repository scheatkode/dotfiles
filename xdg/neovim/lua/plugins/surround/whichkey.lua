local has_whichkey, whichkey = pcall(require, 'which-key')

if not has_whichkey then
   return false
end

whichkey.register({
   ['<leader>t'] = {
      name = '+text/+tab',

      s = {
         name = '+surround',

         C = {'Change surrounding character automatically'},
         D = {'Delete surrounding character automatically'},
         a = {'Add surrounding character'},
         c = {'Change surrounding character'},
         d = {'Delete surrounding character'},
      },
   },
})

whichkey.register({
   i = {
      name = '+inner',

      S = {'Select inside surrounding character automatically'},
      m = {'Select inside surrounding character literally'},
      s = {'Select inside surrounding character'},
   },

   a = {
      name = '+around',

      S = {'Select around surrounding character automatically'},
      m = {'Select around surrounding character literally'},
      s = {'Select around surrounding character'},
   }
}, {
   mode   = 'v',
   prefix = '<leader>',
})

return true
