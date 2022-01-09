local fn = vim.fn
local f  = require('f')
local m  = {}

local defaults = {
   LspDiagnosticsSignError = {
        text = '',
      texthl = 'LspDiagnosticsDefaultError'
   },

   LspDiagnosticsSignWarning = {
        text = '',
      texthl = 'LspDiagnosticsDefaultWarning'
   },

   LspDiagnosticsSignInformation = {
        text = '',
      texthl = 'LspDiagnosticsDefaultInformation'
   },

   LspDiagnosticsSignHint = {
        text = '',
      texthl = 'LspDiagnosticsDefaultHint'
   },
}

--- TODO(scheatkode): documentation
function m.setup (options)
   f.iterate(vim.tbl_deep_extend('force', defaults, options or {}))
    :foreach(function (k, v) fn.sign_define(k, v) end)
end

return m
