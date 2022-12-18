---This function is effectively equivalent to `a < b`.
---
---```lua
---local lt = require('f.operator.lt')
---lt(1, 2) -- true
---lt(1, 1) -- false
---lt(2, 1) -- false
---```
---
---@param a number|string
---@param b number|string
---@return boolean
return function(a, b)
	return a < b
end
