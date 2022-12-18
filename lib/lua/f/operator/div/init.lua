---This function is effectively equivalent to `a / b`.
---
---```lua
---local div = require('f.operator.div')
---div(1, 1) -- 1
---div(1, 2) -- 0.5
---div(4, 2) -- 2
---```
---
---@param a number
---@param b number
---@return boolean
return function(a, b)
	return a / b
end
