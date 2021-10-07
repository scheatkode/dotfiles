-- return { 'b3nj5m1n/kommentary', opt = true,
--    keys = {
--       '<leader>/',
--       '<leader>ccc',

--       '<plug>kommentary_line_default',
--       '<plug>kommentary_motion_default',
--       '<plug>kommentary_visual_default',

--       '<plug>kommentary_line_increase',
--       '<plug>kommentary_motion_increase',
--       '<plug>kommentary_visual_increase',

--       '<plug>kommentary_line_decrease',
--       '<plug>kommentary_motion_decrease',
--       '<plug>kommentary_visual_decrease',
--    },

--   setup = function ()
--      vim.g.kommentary_create_default_mappings = false
--   end,

--    config = function ()
--       require('plugins.comment.whichkey')
--       require('plugins.comment.config')
--       require('plugins.comment.keys')
--    end
-- }

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
