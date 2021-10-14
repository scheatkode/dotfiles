return require('util').register_keymaps {
   {
      mode        = 'n',
      keys        = '<leader>tsd',
      command     = '<Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)',
      description = 'Delete surrounding character',
      options     = { noremap = false },
   },

   {
      mode        = 'n',
      keys        = '<leader>tsD',
      command     = '<Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)',
      description = 'Delete surrounding character automatically',
      options     = { noremap = false },
   },

   {
      mode        = 'n',
      keys        = '<leader>tsc',
      command     = '<Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)',
      description = 'Change surrounding character',
      options     = { noremap = false },
   },

   {
      mode        = 'n',
      keys        = '<leader>tsC',
      command     = '<Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)',
      description = 'Change surrounding character automatically',
      options     = { noremap = false },
   },

   {
      mode        = 'n',
      keys        = '<leader>tsa',
      command     = '<Plug>(operator-sandwich-add)',
      description = 'Add surrounding character',
      options     = { noremap = false },
   },

   {
      mode        = 'x',
      keys        = '<leader>tsa',
      command     = '<Plug>(operator-sandwich-add)',
      description = 'Add surrounding character',
      options     = { noremap = false },
   },

   {
      mode        = 'x',
      keys        = 'is',
      command     = '<Plug>(textobj-sandwich-query-i)',
      description = 'Select inside surrounding character',
      options     = { noremap = false },
   },

   {
      mode        = 'x',
      keys        = 'as',
      command     = '<Plug>(textobj-sandwich-query-a)',
      description = 'Select around surrounding character',
      options     = { noremap = false },
   },

   {
      mode        = 'o',
      keys        = 'is',
      command     = '<Plug>(textobj-sandwich-query-i)',
      description = 'Select inside surrounding character',
      options     = { noremap = false },
   },

   {
      mode        = 'o',
      keys        = 'as',
      command     = '<Plug>(textobj-sandwich-query-a)',
      description = 'Select around surrounding character',
      options     = { noremap = false },
   },

   {
      mode        = 'x',
      keys        = 'iS',
      command     = '<Plug>(textobj-sandwich-auto-i)',
      description = 'Select inside surrounding character automatically',
      options     = { noremap = false },
   },

   {
      mode        = 'x',
      keys        = 'aS',
      command     = '<Plug>(textobj-sandwich-auto-a)',
      description = 'Select around surrounding character automatically',
      options     = { noremap = false },
   },

   {
      mode        = 'o',
      keys        = 'iS',
      command     = '<Plug>(textobj-sandwich-auto-i)',
      description = 'Select inside surrounding character automatically',
      options     = { noremap = false },
   },

   {
      mode        = 'o',
      keys        = 'aS',
      command     = '<Plug>(textobj-sandwich-auto-a)',
      description = 'Select around surrounding character automatically',
      options     = { noremap = false },
   },

   {
      mode        = 'x',
      keys        = 'im',
      command     = '<Plug>(textobj-sandwich-literal-query-i)',
      description = 'Select inside surrounding character literally',
      options     = { noremap = false },
   },

   {
      mode        = 'x',
      keys        = 'am',
      command     = '<Plug>(textobj-sandwich-literal-query-a)',
      description = 'Select around surrounding character literally',
      options     = { noremap = false },
   },

   {
      mode        = 'o',
      keys        = 'im',
      command     = '<Plug>(textobj-sandwich-literal-query-i)',
      description = 'Select inside surrounding character literally',
      options     = { noremap = false },
   },

   {
      mode        = 'o',
      keys        = 'am',
      command     = '<Plug>(textobj-sandwich-literal-query-a)',
      description = 'Select around surrounding character literally',
      options     = { noremap = false },
   },
}
