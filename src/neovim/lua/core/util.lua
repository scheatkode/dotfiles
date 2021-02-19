----------------------------------- util.lua -----------------------------------
-- contains miscellaneous functionality for dealing with lua shortcomings.    --
--------------------------------------------------------------------------------

--- module namespaces
--
-- module namespaces  are  defined  here,  which  will  be  available  when  the
-- module is 'require'd :
--
--   - func  :: miscellaneous utility functions.
--   - array :: utility functions for dealing with arrays.
--   - table :: utility functions and extensions for dealing with tables.
--   - vim   :: utility functions for dealing with (neo)vim.

local m = {
   func  = {confirm = nil},
   array = {},
   table = {},
   vim   = {buffers = {}},
}

-------------------------------- func namespace --------------------------------

--- confirm user approval.
--
-- shows a prompt asking the user to press either 'y' or 'n'
--
-- @param message string → message to be printed to the user.
-- @return boolean       → user approval.

m.func.confirm = function(message)
   print(message .. ' (y/n): ')

   --local answer = string.char(vim.fn.getchar())
   local answer = io.read(1)

   if     'y' == answer then return true
   elseif 'n' == answer then return false
   else
      print('Please enter either "y" or "n"')
      return m.confirm(message)
   end
end


-------------------------------- array namespace -------------------------------

--- validate array.
--
-- check if a table is used as an array, that is, the keys start with 1 and  are
-- sequential for the entire length of the table.
--
-- @param  table table → table to check
-- @return boolean     → true if table is an array, false otherwise

m.array.is_array = function(table)
   -- exit early if the passed argument is not even a table.

   if type(table) ~= 'table' then
      return false
   end

   -- check if the table keys are numerical while keeping tabs on  the  sequence
   -- of indices.

   local i = 1

   -- hint : the value might be 'nil',  in  that  case  'not  table[i]'  is  not
   -- enough, hence the type check.

   for k, _ in pairs(table) do
      if not table[i]
         and type(table[i]) ~= 'nil'
         or  type(k)        ~= 'number'
      then
         return false
      end

      i = i + 1
   end

   -- we made sure of the aforementioned conditions, return true for success.

   return true
end


--- check if a value exists in an array
--
-- searches for the needle in the haystack.
--
-- @param  haystack table → the array.
-- @param  needle   any   → the searched value.
-- @return boolean        → true if needle is found, false otherwise.

m.array.contains = function(haystack, needle)
   for _, v in ipairs(haystack) do
      if v == needle then
         return true
      end
   end

   return false
end


-------------------------------- table namespace -------------------------------

--- unify table api
--
-- unify the table api under a common namespace without redefining  or  touching
-- the global one provided with the language as to not break existing code.

m.table.concat = table.concat
m.table.insert = table.insert
m.table.maxn   = table.maxn
m.table.move   = table.move
m.table.pack   = table.pack
m.table.remove = table.remove
m.table.sort   = table.sort
m.table.unpack = table.unpack


--- check if a value exists
--
-- no need for needles and heystacks, the language itself keeps tabs  about  the
-- defined keys and whatnot, so wrap that functionality  in  a  simple  function
-- call to make code clearer.
--
-- @param set table → table to search
-- @param key any   → key to search for

m.table.contains = function(set, key)
   return set[key] ~= nil
end


--------------------------------- vim namespace --------------------------------

m.vim.buffers.list_loaded = function()
   local api     = vim.api
   local loaded  = {}
   local buffers = api.nvim_list_bufs()

   for _, buffer in ipairs(buffers) do
      if api.nvim_buf_is_loaded(buffer) then
         m.table.insert(loaded, buffer)
      end
   end

   return loaded
end

--- abandon orphaned buffers

m.vim.buffers.close_orphaned = function(force)
   local api        = vim.api
   local buffer_api = vim.bo
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

-- the module and its underlying namespaces are exported here.

return m

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:

-- vim: set sw=3 ts=3 sts=3 et tw=80 fmr={{{,}}} fdl=0 fdm=marker:
