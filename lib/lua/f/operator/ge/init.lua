---This function is effectively equivalent to `a >= b`.
---
---```lua
---local ge = require('f.operator.ge')
---ge(2, 1) -- true
---ge(1, 1) -- true
---ge(1, 2) -- false
---```
---
---@param a number|string
---@param b number|string
---@return boolean
return function(a, b)
	return a >= b
end
