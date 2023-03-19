local a = require("luassert")
local s = require("say")

-- TODO(scheatkode): fix circular references

--- Test  two objects  for equality.  Recursively tests
--- for table contents equality as well.
---
---@param o1 any LHS value
---@param o2 any RHS value
---@param sort? boolean Whether to sort a table before testing for equality
---@return boolean success Whether the given values are equal
local function deep_equal(o1, o2, sort)
	-- if the  two parameters are  primitives, reference
	-- the  same object,  or have  access to  the `__eq`
	-- metamethod, use the provided operator to test for
	-- equality early on.
	if o1 == o2 then
		return true
	end

	local o1_type = type(o1)
	local o2_type = type(o2)

	if o1_type ~= o2_type then
		return false
	end
	if o1_type ~= "table" then
		return false
	end

	if sort then
		table.sort(o1)
		table.sort(o2)
	end

	for o1_key, o1_value in pairs(o1) do
		local o2_value = o2[o1_key]

		if o2_value == nil or not deep_equal(o1_value, o2_value, sort) then
			return false
		end
	end

	for o2_key, o2_value in pairs(o2) do
		local o1_value = o1[o2_key]

		if o1_value == nil or not deep_equal(o1_value, o2_value, sort) then
			return false
		end
	end

	return true
end

local function deep_equal_for_luassert(_, arguments)
	return deep_equal(arguments[1], arguments[2], arguments[3])
end

s:set("assertion.deep_equal.positive", "Expected %s\n to equal\n%s")
s:set("assertion.deep_equal.negative", "Expected %s\n to not equal\n%s")

a:register(
	"assertion",
	"deep_equal",
	deep_equal_for_luassert,
	"assertion.deep_equal.positive",
	"assertion.deep_equal.negative"
)
