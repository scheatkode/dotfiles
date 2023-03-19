local pack = require("compat.table.pack")
local unpack = require("compat.table.unpack")

---A function that partially applies given arguments to the
---right of function `f`, producing another function with
---smaller arity.
---
---Given a function `f: (X × Y × Z) → N`, we might bind the
---first argument, producing a function of type
---`rpartial(f): (X × Y) → N`.
---
---```lua
---local rpartial = require('f.function.rpartial')
---local pipe     = require('f.function.pipe')
---
---local add = function (x, y) return x + y end
---local mul = function (x, y) return x * y end
---
---local add2 = rpartial(add, 2)
---local mul3 = rpartial(mul, 3)
---
---assert.are.same(9, pipe(1, add2, mul3))
---```
---
---@param f function
---@vararg any
---@return function
local function rpartial(f, ...)
	local params = pack(...)
	local paramlen = select("#", ...)

	return function(...)
		local t = pack(...)

		for i = 1, paramlen do
			t[#t + 1] = params[i]
		end

		if t.n ~= nil then
			t.n = t.n + paramlen
		end

		return f(unpack(t))
	end
end

return rpartial
