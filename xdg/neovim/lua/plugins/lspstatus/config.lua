local vfun = vim.fn

local byte2line = vfun.byte2line

local has_status, status = pcall(require, 'lsp-status')

if not has_status then
   print('Tried loading plugin ... unsuccessfully ‼', 'lsp-status')
   return has_status
end

local in_range = require('lsp-status.util').in_range

status.register_progress()

status.config({
   current_function = true,
   diagnostics = false,
   status_symbol = '',
   select_symbol = function(cursor_pos, symbol)
      local vr = symbol.valueRange

      if vr then
         local value_range = {
            start = {
               character = 0,
               line = byte2line(vr[1])
            },
            ['end'] = {
               character = 0,
               line = byte2line(vr[2])
            },
         }

         return in_range(cursor_pos, value_range)
      end
   end
})
