---Negate a predicate.
---@param predicate fun(...): boolean
---@return fun(...): boolean
return function(predicate)
	return function(...)
		return not predicate(...)
	end
end
