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
      require('plugins.align.keys')
   end
}
