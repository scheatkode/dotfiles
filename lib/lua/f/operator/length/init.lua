---This function is effectively equivalent to `#a`.
---
---```lua
---local length = require('f.operator.length')
---length('foo')    -- 3
---length('foobar') -- 6
---```
---
---@param a string|table
---@return number
return function(a)
	return #a
end
