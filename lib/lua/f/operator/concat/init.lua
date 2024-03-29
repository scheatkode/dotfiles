---This function is effectively equivalent to `a .. b`.
---
---```lua
---local concat = require('f.operator.concat')
---concat(1, 1)         -- '11'
---concat(1, 2)         -- '12'
---concat('foo', 'bar') -- 'foobar'
---```
---
---@param a number|string
---@param b number|string
---@return string
return function(a, b)
	return a .. b
end
