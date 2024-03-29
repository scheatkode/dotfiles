---This function is effectively equivalent to `a and b`.
---
---```lua
---local land = require('f.operator.land')
---land(true,  true)  -- true
---land(true,  false) -- false
---land(true,  false) -- false
---land(false, false) -- false
---```
---
---@param a any
---@param b any
---@return boolean
return function(a, b)
	return a and b
end
