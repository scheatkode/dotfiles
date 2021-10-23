local has_whichkey, whichkey = pcall(require, 'which-key')

if has_whichkey then
   whichkey.register({
      ['<F1>'] = { 'Toggle file tree explorer' }
   })
end

return require('util').register_keymaps({{
   mode        = 'n',
   keys        = '<F1>',
   command     = '<Cmd>NvimTreeToggle<CR>',
   description = 'Toggle file tree explorer'
}})
