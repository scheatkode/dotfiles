local getmetatable = getmetatable
local iotype       = io.type
local rawtype      = type
local sformat      = string.format

--- Return  an  *enhaced*  type   name  for  the  given
--- `value`.
---
--- - If `value` has a  metatable, look for a metafield
---   `__type`.
---
---   - Return the type name if it is a string.
---
---   - If it's  a function,  call it with  `value` and
---     return  the  type  name   if  it  is  not  nil,
---     continuing otherwise.
---
--- - If `value` is an  IO userdata (file), then return
---   the result of `io.type`.
---
--- - If none of  the above apply, return  the raw type
---   of `value`,  returning the result of  the builtin
---   `type`.
---
--- @param  value any
--- @return string
local function typex (value)
   local raw_type = rawtype(value)

   if raw_type ~= 'table' and raw_type ~= 'userdata' then
      return raw_type
   end

   local mt = getmetatable(value)

   if mt then
      local mt_type = mt.__type

      if mt_type then
         if rawtype(mt_type) == 'function' then
            mt_type = mt_type(value)
         end

         return mt_type
      end
   end

   if raw_type == 'userdata' then
      local io_type = iotype(value)

      if io_type then return io_type end
   end

   return raw_type
end

--- Return  `true` if  the *enhanced*  type of  `value`
--- meets  `typename`.
---
--- - If the raw type  of `value` is `typename`, return
---   true.
---
--- - If  `value`   has  a  metatable,  look   for  the
---   `__istype` metafield.
---
--- - If the metafield is a function, return the result
---   of  calling  it  with   the  arguments  (`value`,
---   `typename`).
---
---   - Raise an error otherwise.
---
--- - If none of the  above applies, compare the result
---   of `typex(value)` with `typename`.
---
--- @param  typename string
--- @param  value    any
--- @return boolean
local function istypex (typename, value)
   assert(
      rawtype(typename) == 'string',
      sformat('bad argument #1 to "is_typex" (string expected, got %s)', rawtype(typename))
   )

   local raw_type          = rawtype(value)
   local raw_type_equality = raw_type == typename

   if
          raw_type_equality
      or  raw_type ~= 'table'
      and raw_type ~= 'userdata'
   then
      return raw_type_equality
   end

   local mt = getmetatable(value)

   if mt then
      local istype_f = mt.__istype

      if rawtype(istype_f) == 'function' then
         return istype_f(value, typename)
      elseif rawtype(istype_f) == 'string' then
         return istype_f == typename
      elseif istype_f ~= nil then
         error(sformat('invalid metafield "__istype" (function or string expected, got %s)', rawtype(istype_f)))
      end
   end

   return typex(value) == typename
end

return function () return typex, istypex end
