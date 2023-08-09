---Returns `true` if the string ends with the specified suffix, otherwise
---`false`.
---@param str string
---@param suffix string
---@return boolean
return function(str, suffix)
	return string.sub(str, -#suffix) == suffix
end
