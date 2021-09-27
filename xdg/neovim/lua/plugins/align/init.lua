local  has_whichkey, whichkey = pcall(require, 'which-key')

if has_whichkey then
   whichkey.register({
      ['<leader>ta'] = { 'Activate text alignment plugin' },
      ['<leader>tl'] = { 'Activate text alignment plugin' },
   })

   whichkey.register({
      ['<leader>ta'] = { 'Activate text alignment plugin' },
      ['<leader>tl'] = { 'Activate text alignment plugin' },
   })
end

return {'junegunn/vim-easy-align', opt = true,
   cmd = {
      'EasyAlign',
   },

   keys = {
      '<leader>t',
      '<leader>ta',
      '<Plug>(EasyAlign)',
      '<Plug>(LiveEasyAlign)',
   },

   config = function ()
      require('plugins.align.whichkey')
      require('plugins.align.keys')
   end
}
