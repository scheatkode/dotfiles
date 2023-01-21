---@diagnostic disable-next-line: unknown-diag-code
---@diagnostic disable-next-line: incorrect_standard_library_use, deprecated
local unpack = table.unpack or unpack

---Returns the elements from the given list. This function is
---equivalent to:
---```lua
---   return list[i], list[i+1], ···, list[j]
---```
---
---By default, `i` is `1` and `j` is `#list`.
---
---NOTE: This implementation differs from the Lua implementation
---in the way that this one honors the `n` field in the table
---`t`, such that it is *nil-safe*.
---@param t table table to unpack
---@param i number? index from which to start unpacking, defaults to 1
---@param j number? index of the last element to unpack, defaults to `#t`
---@return ...
return function(t, i, j)
	return unpack(t, i or 1, j or t.n or #t)
end
