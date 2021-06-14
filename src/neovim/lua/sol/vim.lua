--------------------------------- vim namespace --------------------------------

local api = vim.api
local bo  = vim.bo
local o   = vim.go

local table = require('sol.table')

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
      if not bo[buffer].buflisted then
         if
            bo[buffer].modified
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

--- commit options
--
-- takes a table of options to loop through and commit.
-- this is intended so  the configuration stays DRY. it
-- takes  care of  setting  the  variables and  joining
-- arrays  (if any),  so  that vim  accepts  them as  a
-- comma-separated string.
--
-- @param  opts table → table of options
-- @return table      → options table

m.apply_options = function(opts)
   for k, v in pairs(opts) do
      if type(v) ~= 'table' then
         o[k] = v
      else
         o[k] = table.concat(v, ',')
      end
   end

   return opts
end

--- commit key mappings
--
-- takes an array of  key mappings and their associated
-- modes and actions to  loop through and commit. this,
-- too, is intended for keeping a DRY configuration.
--
-- @param  maps table → array of keymaps
-- @return table      → keymaps array

m.apply_keymaps = function(keymaps)
   local default_modifiers = {
      silent  = true,
      noremap = true,
   }

   for _, map in pairs(keymaps) do
      if #map == 3 then
         table.insert(map, default_modifiers)
      elseif #map ~= 4 then
         return api.nvim_err_writeln(
            'Invalid keymap format : ' .. vim.inspect(map)
         )
      end

      api.nvim_set_keymap(unpack(map))
   end
end

--- commit key mappings locally
--
-- takes an array of  key mappings and their associated
-- modes and actions to  loop through and commit. this,
-- too, is intended for keeping a DRY configuration.
--
-- @param  maps table → array of keymaps
-- @return table      → keymaps array

m.apply_buffer_keymaps = function(bufnr, keymaps)
   local default_modifiers = {
      silent  = true,
      noremap = true,
   }

   for _, map in pairs(keymaps) do
      if #map == 3 then
         table.insert(map, default_modifiers)
      elseif #map ~= 4 then
         return api.nvim_err_writeln(
            'Invalid keymap format : ' .. vim.inspect(map)
         )
      end

      api.nvim_buf_set_keymap(bufnr, unpack(map))
   end
end

--- commit variables
--
-- takes a set of variables and their associated values
-- to  loop through  and  commit  in neovim's  internal
-- tables.   this   is   intended   for   keeping   DRY
-- configurations as well.
--
-- @param  loc  integer → locality of variables
-- @param  vars table   → array of variables
-- @return table        → variables array

m.apply_variables = function(loc, vars)
   local vim_variable_loc = { 'g', 'b', 'w', 't', 'v' }

   if table.contains(vim_variable_loc, loc) then
      error('Given locality "' .. loc .. '" is invalid.')
   end

   for k, v in pairs(vars) do
      vim[loc][k] = v
   end

   return vars
end

-------------------------------- miscellaneous ---------------------------------

m.escape_termcode = function(s)
   return api.nvim_replace_termcodes(s, true, true, true)
end

-------------------------------- module exports --------------------------------

-- the module is exported here.

return m

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set sw=3 ts=3 sts=3 et tw=78:
