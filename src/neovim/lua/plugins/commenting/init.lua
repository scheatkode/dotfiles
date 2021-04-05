local apply  = require('lib.config').keymaps.use
local plugin = require('kommentary.config')

-- disable creation of default mappings

vim.g.kommentary_create_default_mappings = false

-- additional mappings for increasing/decreasing commenting level for the
-- current line.

plugin.use_extended_mappings()

-- configure commenting behavior

plugin.configure_language('default', {
   prefer_single_line_comments = true,
   use_consistent_indentation  = true,
   ignore_whitespace           = true,
})

plugin.configure_language('php', {
   prefer_single_line_comments = false,
})

-- keyboard mappings

local keymaps = {
   {'n', '<leader>ccc', '<plug>kommentary_line_default',   {}},
   {'n', '<leader>cc',  '<plug>kommentary_motion_default', {}},
   {'v', '<leader>cc',  '<plug>kommentary_visual_default', {}},

   -- extended mappings

   {'n', '<leader>ccic', '<plug>kommentary_line_increase',   {}},
   {'n', '<leader>cci',  '<plug>kommentary_motion_increase', {}},
   {'v', '<leader>cci',  '<plug>kommentary_visual_increase', {}},
   {'n', '<leader>ccdc', '<plug>kommentary_line_decrease',   {}},
   {'n', '<leader>ccd',  '<plug>kommentary_motion_decrease', {}},
   {'v', '<leader>ccd',  '<plug>kommentary_visual_decrease', {}},
}

return apply(keymaps)
