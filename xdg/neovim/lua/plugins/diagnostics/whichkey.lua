local has_whichkey, whichkey = pcall(require, 'which-key')

if not has_whichkey then
   return false
end

whichkey.register({
   ['<leader>clt'] = {
      name = '+diagnostics',

      d = 'Show diagnastics in document',
      l = 'Show diagnastics in loclist',
      q = 'Show diagnastics in quickfix',
      r = 'Show references',
      w = 'Show diagnastics in workspace',
   },
})

return true
