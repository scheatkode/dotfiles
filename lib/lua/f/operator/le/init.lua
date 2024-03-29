---This function is effectively equivalent to `a <= b`.
---
---```lua
---local le = require('f.operator.le')
---le(1, 2) -- true
---le(1, 1) -- true
---le(2, 1) -- false
---```
---
---@param a number|string
---@param b number|string
---@return boolean
return function(a, b)
	return a <= b
end
