local pack = require('compat.table.pack')

---A predicate combiner.
---
---Takes a variable number of predicates and combines them into a single
---function.
---
---```lua
---local constant   = require('f.function.constant')
---local predicates = require('f.function.predicates')
---
---assert.is.truthy(predicates(constant(true), constant(true)))
---assert.is.falsy(predicates(constant(true), constant(false)))
---```
---@vararg fun(...): boolean
---@return fun(...): boolean
return function(...)
	local predicates = pack(...)

	return function(...)
		for _, predicate in ipairs(predicates) do
			if not predicate(...) then
				return false
			end
		end

		return true
	end
end
