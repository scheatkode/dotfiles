local has_whichkey, whichkey = pcall(require, 'which-key')

if not has_whichkey then
   return false
end

whichkey.register({
   ['<leader>cl'] = {
      s = {'Show LSP symbols'},
   },
})

return true
