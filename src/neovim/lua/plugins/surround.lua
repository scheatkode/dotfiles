local apply   = require('lib.config').keymaps.use
local keymaps = {
   {'n', '<leader>tsd',  '<Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)',  {}},
   {'n', '<leader>tsdd', '<Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)',   {}},
   {'n', '<leader>tsc',  '<Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)', {}},
   {'n', '<leader>tsc',  '<Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)',  {}},
   {'n', '<leader>tsa',  '<Plug>(operator-sandwich-add)',                                                                            {}},
   {'x', '<leader>tsa',  '<Plug>(operator-sandwich-add)',                                                                            {}},

   {'x', 'is', '<Plug>(textobj-sandwich-query-i)', {}},
   {'x', 'as', '<Plug>(textobj-sandwich-query-a)', {}},
   {'o', 'is', '<Plug>(textobj-sandwich-query-i)', {}},
   {'o', 'as', '<Plug>(textobj-sandwich-query-a)', {}},

   {'x', 'iss', '<Plug>(textobj-sandwich-auto-i)', {}},
   {'x', 'ass', '<Plug>(textobj-sandwich-auto-a)', {}},
   {'o', 'iss', '<Plug>(textobj-sandwich-auto-i)', {}},
   {'o', 'ass', '<Plug>(textobj-sandwich-auto-a)', {}},

   {'x', 'im', '<Plug>(textobj-sandwich-literal-query-i)', {}},
   {'x', 'am', '<Plug>(textobj-sandwich-literal-query-a)', {}},
   {'o', 'im', '<Plug>(textobj-sandwich-literal-query-i)', {}},
   {'o', 'am', '<Plug>(textobj-sandwich-literal-query-a)', {}},
}

return apply(keymaps)
