---This function is effectively equivalent to `a == b`.
---
---```lua
---local eq = require('f.operator.eq')
---eq(1, 1) -- true
---eq(1, 2) -- false
---```
---
---@param a any
---@param b any
---@return boolean
return function(a, b)
	return a == b
end
