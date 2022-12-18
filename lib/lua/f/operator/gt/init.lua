---This function is effectively equivalent to `a > b`.
---
---```lua
---local gt = require('f.operator.gt')
---gt(2, 1) -- true
---gt(1, 1) -- false
---gt(1, 2) -- false
---```
---
---@param a number|string
---@param b number|string
---@return boolean
return function(a, b)
	return a > b
end
