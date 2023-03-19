---Return a copy of the string with the leading and trailing characters
---removed.
---@param s string
---@return string s Trimmed string.
local function trim(s)
	-- The '()' avoids the overhead of default string capture. This overhead is
	-- small, ~10% for successful whitespace match call alone, and may not be
	-- noticeable even in benchmarks, but there's little harm especially for
	-- such a simple, basic, and commonly used function; every performance
	-- squeeze is beneficiary.
	local from = s:match("^%s*()")

	return from > #s and "" or s:match(".*%S", from)
end

return trim
