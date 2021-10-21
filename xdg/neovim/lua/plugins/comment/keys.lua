return require('util').register_keymaps {{
   mode        = 'n',
   keys        = '<leader>/',
   command     = 'gcc',
   description = 'Comment current line',
   options     = { noremap = false, silent = false },
}, {
   mode        = 'v',
   keys        = '<leader>/',
   command     = 'gc',
   description = 'Comment lines',
   options     = { noremap = false, silent = false },
}}
