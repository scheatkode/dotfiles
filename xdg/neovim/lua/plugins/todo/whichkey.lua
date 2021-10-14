local has_whichkey, whichkey = pcall(require, 'which-key')

if not has_whichkey then
   return false
end

whichkey.register({
   ['<leader>ct'] = {
      name = '+todo',

      t = { 'Show todos in Telescope' },
      d = { 'Show todos in diagnostics buffer' },
      q = { 'Show todos in quickfix window' },
   },

   ['<leader>s'] = {
      t = { 'Search todos' },
   },
})

return true
