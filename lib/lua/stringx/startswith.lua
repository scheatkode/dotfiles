---Returns `true` if the string starts with the specified prefix, otherwise
---`false`.
---@param str string
---@param prefix string
---@return boolean
return function(str, prefix)
	return string.sub(str, 0, #prefix) == prefix
end
