---A function that returns a function that does nothing.
---@type fun(): fun()
return function()
	return function() end
end
