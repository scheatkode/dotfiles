return {'junegunn/vim-easy-align', opt = true,
   cmd = {
      'EasyAlign',
   },

   keys = {
      '<leader>t',
      '<leader>ta',
      '<leader>tl',
      '<Plug>(EasyAlign)',
      '<Plug>(LiveEasyAlign)',
   },

   config = function ()
      require('plugins.align.keys').setup()
   end
}
