---Curried function to check whether `x` is not equal to `y`.
---
---@example
---```lua
---local neq = require('f.function.not_equal')
---neq(x)(y) -- is equivalent to x ~= y
---```
---
---This is especially useful in functional settings, for instance:
---
---@example
---```lua
---filter(table, neq(0)) -- removes `0` values from `table`
---```
local function not_equal(x)
	return function(y) return x ~= y end
end

return not_equal
