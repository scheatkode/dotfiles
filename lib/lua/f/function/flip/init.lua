---flip the order of a binary function's arguments.
---
---@generic A
---@generic B
---@generic C
---
---@type fun(f: fun(a: A, b: B): C): fun(b: B, a: A): C
---
---@param f function function to apply
---@return function f a function accepting the flipped arguments
local function flip(f)
   return function(b, a) return f(a, b) end
end

return flip
