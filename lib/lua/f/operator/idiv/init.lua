local ceil = math.ceil
local floor = math.floor

---This function is effectively equivalent an integer division.
---
---```lua
---local idiv = require('f.operator.idiv')
---idiv(1, 1) -- 1
---idiv(1, 2) -- 0
---idiv(4, 2) -- 2
---```
---
---@param a number
---@param b number
---@return boolean
return function(a, b)
	local q = a / b

	if q >= 0 then
		return floor(q)
	end

	return ceil(q)
end
