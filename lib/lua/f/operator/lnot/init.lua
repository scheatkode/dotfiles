---This function is effectively equivalent to `not a`.
---
---```lua
---local lnot = require('f.operator.lnot')
---lnot(true)  -- false
---lnot(false) -- true
---```
---
---@param a any
---@return boolean
return function(a)
	return not a
end
