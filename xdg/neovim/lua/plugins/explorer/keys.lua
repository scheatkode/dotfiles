local has_whichkey, whichkey = pcall(require, 'which-key')

if has_whichkey then
   whichkey.register({
      ['<leader>ft'] = { 'Toggle file tree explorer' }
   })
end

return require('util').register_keymaps({{
   mode        = 'n',
   keys        = '<leader>ft',
   command     = '<Cmd>NvimTreeToggle<CR>',
   description = 'Toggle file tree explorer'
}})
