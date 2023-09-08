---Filter the given `table` with the given `predicate`.
---Note: Assumes the `table` is a Lua Array.
---@param t table
---@param predicate fun(t: table, i: number, j: number): boolean
---@return table
return function(t, predicate)
	local j, n = 1, #t

	for i = 1, n do
		if predicate(t, i, j) then
			-- Move i's kept value to j's position, if it's not
			-- already there.
			if i ~= j then
				t[j] = t[i]
				t[i] = nil
			end

			-- Increment position of where we'll place the next
			-- kept value.
			j = j + 1
		else
			t[i] = nil
		end
	end

	return t
end
