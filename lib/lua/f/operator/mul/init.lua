---This function is effectively equivalent to `a * b`.
---
---```lua
---local mul = require('f.operator.mul')
---mul(1, 1) -- 1
---mul(2, 2) -- 4
---```
---
---@param a number
---@param b number
---@return boolean
return function(a, b)
	return a * b
end
