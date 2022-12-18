---This function is effectively equivalent to `a - b`.
---
---```lua
---local sub = require('f.operator.sub')
---sub(1, 1) -- 0
---sub(1, 2) -- -1
---```
---
---@param a number
---@param b number
---@return boolean
return function(a, b)
	return a - b
end
