local compat = require('compat')

local callbacks = _G.callbacks or {}

local m = {}

---converts path parts to a string.
---@param parts table parts to merge
---@return string path merged path
m.parts_to_path = function (parts)
	return table.concat(parts, compat.path_separator)
end


---create a table from multiple parts.
---@vararg ...
---@return table
m.parts_to_table = function (...) return { ... } end

_G.callbacks = callbacks
return m
