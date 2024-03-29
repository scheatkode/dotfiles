---This function is effectively equivalent to `a ^ b`.
---
---```lua
---local pow = require('f.operator.pow')
---pow(1, 1) -- 1
---pow(2, 3) -- 8
---```
---
---@param a number
---@param b number
---@return boolean
return function(a, b)
	return a ^ b
end
