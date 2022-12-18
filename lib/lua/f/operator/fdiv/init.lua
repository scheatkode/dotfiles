local floor = math.floor

---This function is effectively equivalent to `math.floor(a / b)`.
---
---```lua
---local fdiv = require('f.operator.fdiv')
---fdiv(1, 1) -- 1
---fdiv(1, 2) -- 0
---fdiv(4, 2) -- 2
---```
---
---@param a number
---@param b number
---@return boolean
return function(a, b)
	return floor(a / b)
end
