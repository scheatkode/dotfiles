---A function that simulates a lazily evaluated ternary
---operator.
---
---```lua
---local constant = require('f.function.constant')
---local ternary  = require('f.function.ternary')
---
---assert.are.same('left',  condition(constant(true),  constant('left'), constant('right')))
---assert.are.same('right', condition(constant(false), constant('left'), constant('right')))
---```
---
---@param predicate fun(...): boolean
---@param if_true fun(...): A
---@param if_false fun(...): B
---@return A|B
return function(predicate, if_true, if_false)
	return function(...)
		if predicate(...) then
			return if_true(...)
		else
			return if_false(...)
		end
	end
end
