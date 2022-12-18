---This function is effectively equivalent to `a - 1`.
---
---```lua
---local dec = require('f.operator.dec')
---dec(1) -- 0
---dec(2) -- 1
---```
---
---@param a number
---@return boolean
return function(a)
	return a - 1
end
