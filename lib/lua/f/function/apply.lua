--- @generic A
--- @generic B
---
--- @type fun(a: A): fun(f: fun(a: A): B): B
local function apply (a)
   return function(f) return f(a) end
end

return apply
