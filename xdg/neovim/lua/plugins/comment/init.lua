return {'numToStr/Comment.nvim', opt = true,
   keys = {
      'gcc',
      'gcb',
   },

   wants = {
      'treesitter-comment-string'
   },

   config = function ()
      require('plugins.comment.config')
   end
}
