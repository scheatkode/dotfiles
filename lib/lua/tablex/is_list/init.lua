---Test if a Lua table can be treated as an array.
---
---Note: Empty table `{}` is assumed to be an array.
---@param table table
---@return boolean `true` if array-like table, `false` otherwise
return function(table)
	if type(table) ~= "table" then
		return false
	end

	for k, _ in pairs(table) do
		if type(k) ~= "number" then
			return false
		end
	end

	return true
end
