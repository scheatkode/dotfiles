---------------------------------- config.lua ----------------------------------
--                                                                            --
--          contains functionality for DRYing up yuor configuration.          --
--                                                                            --
--------------------------------------------------------------------------------


--- dependencies
--
-- override the  'table' namespace  with a  unified one
-- containing all the necessary functionality.

local table = require('lib').table

--- module namespaces
--
-- module namespaces  are defined  here, which  will be
-- available when the module is 'require'd :
--
--   - keymaps   :: utility functions for vim keymap handling.
--   - options   :: utility functions for vim option handling.
--   - variables :: utility functions for vim variable handling.

local m = {
   keymaps   = {},
   options   = {},
   variables = {},
}


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

m.options.use = function(opts)
   for k, v in pairs(opts) do
      if type(v) ~= 'table' then
         vim.o[k] = v
      else
         vim.o[k] = table.concat(v, ',')
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

m.keymaps.use = function(maps)
   local api = vim.api

   for _, map in ipairs(maps) do
      if #map ~= 4 then
         return api.nvim_err_writeln(
            'Invalid keymap format : ' .. vim.inspect(map)
         )
      end

      api.nvim_set_keymap(unpack(map))
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

m.variables.use = function(loc, vars)
   local vim_variable_loc = { 'g', 'b', 'w', 't', 'v' }

   if table.contains(vim_variable_loc, loc) then
      error('given locality "' .. loc .. '" is invalid')
   end

   for k, v in pairs(vars) do
      vim[loc][k] = v
   end

   return vars
end


--- module exports
--
-- the  module   and  its  underlying   namespaces  are
-- exported here.

return m

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set sw=3 ts=3 sts=3 et tw=80 fmr={{{,}}} fdl=0 fdm=marker:
