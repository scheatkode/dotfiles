---@diagnostic disable-next-line: unknown-diag-code
---@diagnostic disable-next-line: incorrect_standard_library_use, deprecated
if not table.pack then
	---Returns a new table with all arguments stored into keys `1`, `2`, etc.
	---and with a field `"n"` with the total number of arguments.
	---@vararg any
	---@return table
	return function(...)
		return {
			n = select("#", ...),
			...,
		}
	end
end

---@diagnostic disable-next-line: unknown-diag-code
---@diagnostic disable-next-line: incorrect_standard_library_use, deprecated
return table.pack
