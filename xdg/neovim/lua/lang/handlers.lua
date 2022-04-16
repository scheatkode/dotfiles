local f = require('f')
local m = {}

local defaults = {
   ['textDocument/publishDiagnostics'] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
         virtual_text = {
            prefix  = '»',
            spacing = 3,
         },

         underline = true,

         signs = true,
         update_in_insert = false,
      }
   )
}

--- TODO(scheatkode): documentation
function m.setup(options)
   f.iterate(vim.tbl_extend('force', defaults, options or {}))
    :foreach(function (k, v) vim.lsp.handlers[k] = v end)
end

return m
