---A function that simulates a lazily evaluated ternary
---operator.
---
---```lua
---local constant = require('f.function.constant')
---local ternary  = require('f.function.ternary')
---
---assert.are.same('left',  ternary(true,  constant('left'), constant('right')))
---assert.are.same('right', ternary(false, constant('left'), constant('right')))
---```
---
---@param condition boolean
---@param if_true fun(): A
---@param if_false fun(): B
---@return A|B
return function(condition, if_true, if_false)
	if condition then return if_true() else return if_false() end
end
