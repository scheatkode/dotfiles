local assertx = require("assertx")
local memoize = require("f.function.memoize")
local is_empty = require("tablex.is_empty")
local is_list = require("tablex.is_list")

local type = type

local function can_merge(v)
	return type(v) == "table" and (is_empty(v) or not is_list(v))
end

local function deep_extend_impl(is_mergeable, is_not_force, is_error, ...)
	local result = {}

	for i = 1, select("#", ...) do
		local t = select(i, ...)

		if not t then
			return result
		end

		for k, v in pairs(t) do
			if is_mergeable(v) and is_mergeable(result[k]) then
				result[k] = deep_extend_impl(
					is_mergeable,
					is_not_force,
					is_error,
					result[k],
					v
				)
			elseif is_not_force and result[k] ~= nil then
				if is_error then
					error("key found in more than one map: " .. k)
				end -- else behavior is 'keep'
			else
				result[k] = v
			end
		end
	end

	return result
end

--- Merge two or more map-like tables.
--- @param behavior 'error'|'keep'|'force' Decide what to do if a key is found - in more than one map :
---   - 'error': raise an error
---   - 'keep': use value from the leftmost map
---   - 'force': use value from the rightmost map
--- @vararg ... Two or more map-like tables.
return function(behavior, ...)
	assertx(
		behavior == "error" or behavior == "force" or behavior == "keep",
		string.format,
		'invalid behavior: "%s"',
		behavior
	)

	assertx(
		select("#", ...) >= 2,
		string.format,
		"wrong number of arguments: given %s, expected at least 3",
		select("#", ...)
	)

	return deep_extend_impl(
		memoize(can_merge),
		behavior ~= "force",
		behavior == "error",
		...
	)
end
