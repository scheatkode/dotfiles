---Store a variable in a closure to be retrieved later when the
---closure is called.
---
---@param a A
---@type fun(a: A): fun(): A
return function(a)
	return function() return a end
end
