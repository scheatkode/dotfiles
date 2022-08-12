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
      require('plugins.comment.config').setup()
      require('plugins.comment.keys').setup()
   end
}
