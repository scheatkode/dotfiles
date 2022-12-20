local require = require

---Require when an exported method is called.
---
---Creates a new function. Cannot be used to compare functions,
---set new values, etc. Only useful for waiting to do the
---require until the exported function is actually called.
return function(path)
	return setmetatable({}, {
		__index = function(_, key)
			return function(...)
				return require(path)[key](...)
			end
		end,
	})
end
