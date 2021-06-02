-------------------------------- table namespace -------------------------------

local m = {}

--- unify table api
--
-- unify the table api under a common namespace without redefining  or  touching
-- the global one provided with the language as to not break existing code.

m.concat = table.concat
m.insert = table.insert
m.maxn   = table.maxn
m.move   = table.move
m.pack   = table.pack
m.remove = table.remove
m.sort   = table.sort
m.unpack = unpack or table.unpack


--- check if a value exists
--
-- no need for needles and heystacks, the language itself keeps tabs  about  the
-- defined keys and whatnot, so wrap that functionality  in  a  simple  function
-- call to make code clearer.
--
-- @param set table → table to search
-- @param key any   → key to search for

m.contains = function(set, key)
   return set[key] ~= nil
end


-------------------------------- module exports --------------------------------

-- the module is exported here.

return m

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set ft=lua sw=3 ts=3 sts=3 et tw=78:
