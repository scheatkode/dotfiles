---This function is effectively equivalent to `a or b`.
---
---```lua
---local lor = require('f.operator.lor')
---lor(true,  true)  -- true
---lor(true,  false) -- true
---lor(true,  false) -- true
---lor(false, false) -- false
---```
---
---@param a any
---@param b any
---@return boolean
return function(a, b)
	return a or b
end
