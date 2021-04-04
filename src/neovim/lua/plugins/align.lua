local apply   = require('lib.config').keymaps.use

local keymaps = {
   {'n', '<leader>ta', '<Plug>(EasyAlign)', {}},
   {'x', '<leader>ta', '<Plug>(EasyAlign)', {}},
}

return apply(keymaps)
