local function part(f, x)
	return function(...)
		return f(x, ...)
	end
end

---A function that partially applies given arguments to the
---function `f`, producing another function with smaller arity.
---
---Given a function `f: (X × Y × Z) → N`, we might bind the
---first argument, producing a function of type
---`partial(f): (Y × Z) → N`.
---
---```lua
---local partial = require('f.function.partial')
---local pipe    = require('f.function.pipe')
---
---local add = function (x, y) return x + y end
---local mul = function (x, y) return x * y end
---
---local add2 = partial(add, 2)
---local mul3 = partial(mul, 3)
---
---assert.are.same(9, pipe(1, add2, mul3))
---```
---
---@param f function
---@vararg any
---@return function
local function partial(f, ...)
	for i = 1, select('#', ...) do
		f = part(f, select(i, ...))
	end

	return f
end

return partial
