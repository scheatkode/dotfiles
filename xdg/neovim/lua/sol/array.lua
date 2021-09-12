-------------------------------- array namespace -------------------------------

local m = {}

--- validate array.
--
-- check if a table is used as an array, that is, the keys start with 1 and  are
-- sequential for the entire length of the table.
--
-- @param  table table → table to check
-- @return boolean     → true if table is an array, false otherwise

m.is_array = function(table)
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

m.contains = function(haystack, needle)
   for _, v in ipairs(haystack) do
      if v == needle then
         return true
      end
   end

   return false
end


-------------------------------- module exports --------------------------------

-- the module is exported here.

return m
