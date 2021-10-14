return require('util').register_keymaps {{
   mode        = 'n',
   keys        = '<leader>/',
   command     = '<plug>kommentary_line_default',
   description = 'Comment current line',
   options     = { noremap = false, silent = false },
}, {
   mode        = 'n',
   keys        = '<leader>ccc',
   command     = '<plug>kommentary_line_default',
   description = 'Comment current line',
   options     = { noremap = false, silent = false },
}, {
   mode        = 'n',
   keys        = '<leader>ccm',
   command     = '<plug>kommentary_motion_default',
   description = 'Comment lines with motion',
   options     = { noremap = false, silent = false },
}, {
   mode        = 'v',
   keys        = '<leader>/',
   command     = '<plug>kommentary_visual_default',
   description = 'Comment lines',
   options     = { noremap = false, silent = false },
}, {
   mode        = 'v',
   keys        = '<leader>ccc',
   command     = '<plug>kommentary_visual_default',
   description = 'Comment lines',
   options     = { noremap = false, silent = false },
}, {
   mode        = 'v',
   keys        = '<leader>ccc',
   command     = '<plug>kommentary_visual_default',
   description = 'Comment lines',
   options     = { noremap = false, silent = false },
}, {
   mode        = 'n',
   keys        = '<leader>ccic',
   command     = '<plug>kommentary_line_increase',
   description = 'Increase line comment',
   options     = { noremap = false, silent = false },
}, {
   mode        = 'n',
   keys        = '<leader>ccim',
   command     = '<plug>kommentary_motion_increase',
   description = 'Increase line comment with motion',
   options     = { noremap = false, silent = false },
}, {
   mode        = 'v',
   keys        = '<leader>cci',
   command     = '<plug>kommentary_visual_increase',
   description = 'Increase line comment',
   options     = { noremap = false, silent = false },
}, {
   mode        = 'n',
   keys        = '<leader>ccdc',
   command     = '<plug>kommentary_line_decrease',
   description = 'Decrease line comment',
   options     = { noremap = false, silent = false },
}, {
   mode        = 'n',
   keys        = '<leader>ccdm',
   command     = '<plug>kommentary_motion_decrease',
   description = 'Decrease line comment with motion',
   options     = { noremap = false, silent = false },
}, {
   mode        = 'v',
   keys        = '<leader>ccd',
   command     = '<plug>kommentary_visual_decrease',
   description = 'Decrease line comment',
   options     = { noremap = false, silent = false },
}}
