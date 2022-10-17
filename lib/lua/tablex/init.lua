local m = {}

--- Check if a table is empty.
---@param t table Table to check
function m.is_empty(t)
   assert(
      type(t) == 'table',
      string.format('Expected table, got %s', type(t))
   )

   return next(t) == nil
end

--- Test if a Lua table can be treated as an array.
---
--- Note: Empty table `{}` is assumed to be an array.
---@param t table
---@return boolean `true` if array-like table, `false` otherwise
function m.is_list(t)
   if type(t) ~= 'table' then
      return false
   end

   for k, _ in pairs(t) do
      if type(k) ~= 'number' then
         return false
      end
   end

   return true
end

local function can_merge (v)
   return
      type(v) == 'table'
      and (
                m.is_empty(v)
         or not m.is_list(v)
      )
end

--- Merge two or more map-like tables.
--- @param behavior 'error'|'keep'|'force' Decide what to do if a key is found - in more than one map :
---   - 'error': raise an error
---   - 'keep': use value from the leftmost map
---   - 'force': use value from the rightmost map
--- @vararg ... Two or more map-like tables.
function m.deep_extend(behavior, ...)
   local behavior_is_error     = behavior == 'error'

   local behavior_is_not_error = behavior ~= 'error'
   local behavior_is_not_force = behavior ~= 'force'
   local behavior_is_not_keep  = behavior ~= 'keep'

   if
          behavior_is_not_error
      and behavior_is_not_force
      and behavior_is_not_keep
   then
      error('invalid behavior: ' .. tostring(behavior))
   end

   if select('#', ...) < 2 then
      error(
            'wrong number of arguments (given '
         .. tostring(1 + select('#', ...))
         .. ', expected at least 3'
      )
   end

   local out = {}

   for i = 1, select('#', ...) do
      local t = select(i, ...)

      if t then
         for k, v in pairs(t) do
            if can_merge(v) and can_merge(out[k]) then
               out[k] = m.deep_extend(behavior, out[k], v)
            elseif behavior_is_not_force and out[k] ~= nil then
               if behavior_is_error then
                  error('key found in more than one map: ' .. k)
               end -- else behavior is 'keep'
            else
               out[k] = v
            end
         end
      end
   end

   return out
end

m.extend = require('tablex.extend')

return m
