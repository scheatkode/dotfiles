--------------------------------- vim namespace --------------------------------

local api        = vim.api
local buffer_api = vim.bo

local m = {
   buffer = {},
}

m.buffer.list_loaded = function()
   local loaded  = {}
   local buffers = api.nvim_list_bufs()

   for _, buffer in ipairs(buffers) do
      if api.nvim_buf_is_loaded(buffer) then
         table.insert(loaded, buffer)
      end
   end

   return loaded
end

--- abandon orphaned buffers

m.buffer.close_orphaned = function(force)
   local buffers    = api.nvim_list_bufs()
   local modified   = 0
   local options    = {
      force = force
         and true
         or  false
   }

   if #buffers == 1 then
      return
   end

   for _, buffer in ipairs(buffers) do
      if not buffer_api[buffer].buflisted then
         if buffer_api[buffer].modified
            and not options.force
         then
            modified = modified + 1
            goto continue
         else
            api.nvim_buf_delete(buffer, options)
         end
      end

   ::continue::
   end

   if modified == 1 then
      return api.nvim_err_writeln('One buffer modified, skipped.')
   elseif modified > 1 then
      return api.nvim_err_writeln(modified .. ' buffers modified, skipped.')
   end
end

-------------------------------- module exports --------------------------------

-- the module is exported here.

return m

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set sw=3 ts=3 sts=3 et tw=80
