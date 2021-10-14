local has_whichkey, whichkey = pcall(require, 'which-key')

if not has_whichkey then
   return has_whichkey
end

whichkey.register({
   ['<leader>t'] = {
      a = {'Align text'},
   },
})

whichkey.register({
   ['<leader>t'] = {
      a = {'Align text'},
   },
}, {
   mode    = 'v',
   noremap = false,
})
