------------------------------- string namespace -------------------------------

local m = {}

--- unify string api
--
-- unify the string api under a common namespace without redefining  or  touching
-- the global one provided with the language as to not break existing code.

m.len    = string.len
m.length = string.len

m.is_empty = function (s)
   return s == nil or s == ''
end


-------------------------------- module exports --------------------------------

-- the module is exported here.

return m
