local assertx = require("assertx")

---Check if a table is empty.
---@param table table Table to check
return function(table)
	assertx(
		type(table) == "table",
		string.format,
		"Expected table, got %s",
		type(table)
	)

	return next(table) == nil
end
