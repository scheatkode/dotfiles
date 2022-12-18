---This function is effectively equivalent to `a + 1`.
---
---```lua
---local inc = require('f.operator.inc')
---inc(1) -- 2
---inc(2) -- 3
---```
---
---@param a number
---@return boolean
return function(a)
	return a + 1
end
