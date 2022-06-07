local partial = require('f.function.partial')

---Convert `f`, a function that takes multiple arguments into
---a sequence of functions that take an arbitrary number of
---arguments until the original functions arguments have been
---filled.
---
---```lua
---local curry = require('f.function.curry')
---local add   = function (x, y, z) return x + y + z end
---
---assert.are.same(9, curry(add)(2)(3)(4))
---```
---
---@param f function
---@param n number?
---@return function
local function curry(f, n)
	n = n or debug.getinfo(f, 'u').nparams or 2

	if n < 2 then return f end

	return function(...)
		local nargs = select('#', ...)

		if nargs >= n then
			return f(...)
		end

		return curry(partial(f, ...), n - nargs)
	end
end

return curry
