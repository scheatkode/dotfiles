---This function is effectively equivalent to `-a`.
---
---```lua
---local neg = require('f.operator.neg')
---neg(1) -- -1
---neg(2) -- -2
---```
---
---@param a number
---@return number
return function(a)
	return -a
end
