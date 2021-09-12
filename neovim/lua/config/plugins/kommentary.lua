--- configure kommentary

local ok, kommentary = pcall(require, 'kommentary.config')

if not ok then
   print('‼ Tried loading kommentary ... unsuccessfully.')
   return ok
end

-- disable creation of default mappings

vim.g.kommentary_create_default_mappings = false

-- additional mappings for increasing/decreasing commenting level for the
-- current line.

kommentary.use_extended_mappings()

-- configure commenting behavior

kommentary.configure_language('default', {
   prefer_single_line_comments = true,
   use_consistent_indentation  = true,
   ignore_whitespace           = true,
})

kommentary.configure_language('php', {
   prefer_single_line_comments = false,
})

-- keyboard mappings

require('sol.vim').apply_keymaps({
   {'n', '<leader>/', '<plug>kommentary_line_default',   {}},
   {'n', '<leader>ccc', '<plug>kommentary_line_default',   {}},
   {'n', '<leader>ccm',  '<plug>kommentary_motion_default', {}},
   {'v', '<leader>/', '<plug>kommentary_visual_default',   {}},
   {'v', '<leader>ccc',  '<plug>kommentary_visual_default', {}},

   -- extended mappings

   {'n', '<leader>ccic', '<plug>kommentary_line_increase',   {}},
   {'n', '<leader>ccim',  '<plug>kommentary_motion_increase', {}},
   {'v', '<leader>cci',  '<plug>kommentary_visual_increase', {}},

   {'n', '<leader>ccdc', '<plug>kommentary_line_decrease',   {}},
   {'n', '<leader>ccdm',  '<plug>kommentary_motion_decrease', {}},
   {'v', '<leader>ccd',  '<plug>kommentary_visual_decrease', {}},
})

--- whichkey setup

local has_whichkey, whichkey = pcall(require, 'which-key')

if not has_whichkey then
   return has_whichkey
end

whichkey.register({
   ['<leader>c'] = {
      name = '+code',

      c = {
         name = '+comment',

         c = {'Comment line'},
         m = {'Comment motion'},

         i = {
            name = '+increase',

            c = {'Increase commenting level for line'},
            m = {'Increase commenting level for motion'},
         },

         d = {
            name = '+decrease',

            c = {'Decrease commenting level for line'},
            m = {'Decrease commenting level for motion'},
         },
      },
   },
})

whichkey.register({
   ['<leader>c'] = {
      name = '+code',

      c = {
         name = '+comment',

         c = {'Comment selection'},
         i = {'Increase commenting level'},
         d = {'Decrease commenting level'},
      },
   },
}, {
   mode = 'v',
})
