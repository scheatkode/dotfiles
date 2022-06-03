local compat = require('compat')
local unpack = compat.table_unpack
local type   = type

---Raises an error if the value of its argument v is falsy
---(i.e., `nil` or `false`); otherwise, returns all its
---arguments. In case of error, if the second argument is
---a function, it is called with the rest of the arguments;
---when absent, it defaults to printing `"assertion failed!"`
---
---This is a faster variant of the default `assert` function
---that lazily evaluates its arguments only if the assertion
---fails.
---
---@example
---```lua
---local assertx = require('assertx')
---
---assertx(a == b, string.format, '%s is not equal to %s', a, b)
---```
---
---@param v any Expression to be tested for truthiness.
---@param ... any Rest arguments.
---@return ... any The given arguments.
local function assertx(v, ...)
	if v then return v, ... end

	local f = ...

	if type(f) == 'function' then
		local arguments = { ... }
		table.remove(arguments, 1)
		error(f(unpack(arguments)), 2)
	end

	error(f or 'assertion failed!', 2)
end

return assertx
