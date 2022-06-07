local function recurse(i, chain, ...)
	if i == #chain then
		return chain[i](...)
	end

	return recurse(i + 1, chain, chain[i](...))
end

---Perform left-to-right function composition. the first
---argument may have - any arity, the remaining arguments must
---be unary. This effectively creates a function that takes the
---arguments of the first function and gives the return value of
---the last function, applying every function in between.
---
---```lua
---local compose = require('f.function.compose')
---
---local length = function(s: string): number return #s    end
---local double = function(n: number): number return n * 2 end
---
---local f = compose(length, double)
---
---assert.same(6, f('foo'))
---```
local function compose(...)

	-- This function taps into Lua's tail call optimization to
	-- getting a performance hit because of `unpack`.

	local chain = { ... }

	return function(...)
		return recurse(1, chain, ...)
	end
end

return compose
