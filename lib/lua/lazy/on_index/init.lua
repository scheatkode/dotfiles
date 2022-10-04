local require = require

---Require on index.
---
---Will only require the module at `path` after the first
---indexing of its exported table.
---NOTE: Only works for modules that export a table.
return function(path)
	return setmetatable({}, {
		__index = function(_, key)
			return require(path)[key]
		end,

		__new_index = function(_, key, value)
			require(path)[key] = value
		end
	})
end
