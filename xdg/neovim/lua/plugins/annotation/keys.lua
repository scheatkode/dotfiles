local annotation = require('neogen')

return require('util').register_keymaps {
   {
      mode        = 'n',
      keys        = '<leader>cn',
      command     = annotation.generate,
      description = 'Generate annotation for current node'
   },
   {
      mode        = 'n',
      keys        = '<leader>cnf',
      command     = function () annotation.generate({ type = 'func' }) end,
      description = 'Generate annotation for current function'
   },
   {
      mode        = 'n',
      keys        = '<leader>cnc',
      command     = function () annotation.generate({ type = 'class' }) end,
      description = 'Generate annotation for current class'
   },
   {
      mode        = 'n',
      keys        = '<leader>cnt',
      command     = function () annotation.generate({ type = 'type' }) end,
      description = 'Generate annotation for current type'
   }
}
