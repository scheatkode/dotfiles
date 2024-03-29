---This function is effectively equivalent to `a + b`.
---
---```lua
---local add = require('f.operator.add')
---add(1, 1) -- 2
---add(1, 2) -- 3
---```
---
---@param a number
---@param b number
---@return boolean
return function(a, b)
	return a + b
end
