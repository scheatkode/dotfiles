return {'numToStr/Comment.nvim', opt = true,
   keys = {
      '<leader>/',
      'gcc',
      'gcb',
      'gco',
      'gcO',
      'gcA',
   },

   wants = {
      'treesitter-comment-string'
   },

   config = function ()
      require('plugins.comment.config')
      require('plugins.comment.keys')
   end
}
