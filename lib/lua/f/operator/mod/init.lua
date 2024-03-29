---This function is effectively equivalent to `a % b`.
---
---```lua
---local mod = require('f.operator.mod')
---mod(2, 2) -- 0
---mod(1, 2) -- 1
---```
---
---@param a number
---@param b number
---@return boolean
return function(a, b)
	return a % b
end
