local require = require

---Requires the module at `path` only when it's called.
return function(path)
	return setmetatable({}, {
		__call = function(_, ...)
			return require(path)(...)
		end,
	})
end
