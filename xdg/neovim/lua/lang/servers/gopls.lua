local pipe          = require('f.function.pipe')
local parts_to_path = require('util').parts_to_path

return {
   cmd = {
      pipe({
         vim.fn.stdpath('data'),
         'lsp_servers',
         'go',
         'gopls',
      },
         parts_to_path,
         vim.fn.expand
      ),

      'serve'
   }
}
