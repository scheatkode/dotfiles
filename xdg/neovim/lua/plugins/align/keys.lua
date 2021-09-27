return require('util').register_keymaps {{
   mode        = 'n',
   keys        = '<leader>ta',
   command     = '<Plug>(EasyAlign)',
   description = 'Align text',
   options     = { noremap = false, silent = false },
}, {
   mode        = 'x',
   keys        = '<leader>ta',
   command     = '<Plug>(EasyAlign)',
   description = 'Align text',
   options     = { noremap = false, silent = false },
},{
   mode        = 'n',
   keys        = '<leader>tl',
   command     = '<Plug>(LiveEasyAlign)',
   description = 'Align text (live)',
   options     = { noremap = false, silent = false },
}, {
   mode        = 'x',
   keys        = '<leader>tl',
   command     = '<Plug>(LiveEasyAlign)',
   description = 'Align text (live)',
   options     = { noremap = false, silent = false },
}}
