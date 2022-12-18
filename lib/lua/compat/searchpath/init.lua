if package.searchpath then
	return package.searchpath
end

local assertx   = require('assertx')
local separator = require('compat.separator')

---Get the full path where a file name would have matched. This
---function was introduced in Lua 5.2. This compatibility version
---will be injected in Lua 5.1 engines.
---
---@param name string file name, possibly dotted
---@param path string a path-template in the same form as `package.path` or `package.cpath`
---@param sep? string template separate character to be replaced by path separator. Default: '.'
---@param rep? string path separator to use, defaults to system separator
---@return string? filename path of the file on success
---@return string? errormsg on failure, the error string lists the paths tried
return function(name, path, sep, rep)
	local type = type

	assertx(
		type(name) == 'string',
		string.format,
		"bad argument #1 to 'searchpath' (string expected, got %s)",
		type(path),
		2
	)
	assertx(
		type(path) == 'string',
		string.format,
		"bad argument #2 to 'searchpath' (string expected, got %s)",
		type(path),
		2
	)
	assertx(
		sep == nil or type(sep) == 'string',
		string.format,
		"bad argument #3 to 'searchpath' (string expected, got %s)",
		type(path),
		2
	)
	assertx(
		rep == nil or type(rep) == 'string',
		string.format,
		"bad argument #4 to 'searchpath' (string expected, got %s)",
		type(path),
		2
	)

	sep = sep or '.'
	rep = rep or separator

	do
		local s, e = name:find(sep, nil, true)

		while s do
			name = string.format(
				'%s%s%s',
				name:sub(1, s - 1),
				rep,
				name:sub(e + 1, -1)
			)

			s, e = name:find(sep, s + #rep + 1, true)
		end
	end

	local paths_tried = {}

	for m in path:gmatch('[^;]+') do
		local nm = m:gsub('?', name)
		local f  = io.open(nm, 'r')

		paths_tried[#paths_tried + 1] = nm

		if f then
			f:close()
			return nm
		end
	end

	return nil,
		"\n\tno file '" .. table.concat(paths_tried, "'\n\tno file '") .. "'"
end
