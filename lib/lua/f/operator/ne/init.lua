---This function is effectively equivalent to `a ~= b`.
---
---```lua
---local ne = require('f.operator.ne')
---ne(1, 1) -- true
---ne(1, 2) -- false
---```
---
---@param a any
---@param b any
---@return boolean
return function(a, b)
	return a ~= b
end
