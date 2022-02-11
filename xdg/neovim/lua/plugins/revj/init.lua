return {
   'AckslD/nvim-revJ.lua',

   opt = true,

   keys = {
      {'n', '<leader>J'},
      {'v', '<leader>J'},
   },

   requires = {
      'kana/vim-textobj-user',
      'sgur/vim-textobj-parameter',
   },

   config = function ()
      require('plugins.revj.config')
   end,
}
