local has_whichkey, whichkey = pcall(require, 'which-key')

if not has_whichkey then
   return false
end

whichkey.register({
   ['<leader>cd'] = {
      name = '+dap',

      e = 'Evaluate',
   },
})

whichkey.register({
   ['<leader>cd'] = {
      name = '+dap',

      e = 'Evaluate',
   },
}, {
   mode = 'v'
})
