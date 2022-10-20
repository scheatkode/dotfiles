local require = require

---Requires the module at `path` only when it's called.
return function(path)
	return function(...) return require(path)(...) end
end
