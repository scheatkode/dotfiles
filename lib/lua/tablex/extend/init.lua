--- Merge two or more map-like tables.
--- @vararg ... Two or more map-like tables.
return function(...)
	local result = {}

	for i = 1, select('#', ...) do
		local argument = select(i, ...)

		if argument ~= nil then
			for k, v in pairs(argument) do
				result[k] = v
			end
		end
	end

	return result
end
