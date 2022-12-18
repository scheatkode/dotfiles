---This function is effectively equivalent to `not not a`.
---
---```lua
---local ltruth = require('f.operator.ltruth')
---ltruth(true)  -- true
---ltruth(false) -- false
---ltruth(1)     -- true
---```
---
---@param a any
---@return boolean
return function(a)
	return not not a
end
