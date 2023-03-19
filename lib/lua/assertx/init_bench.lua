do
	local sf = string.format

	-- bare bones way of getting the running script's file name
	-- and directory.
	local this_filename = debug.getinfo(1, "S").source:sub(2)
	local this_directory = this_filename:match("(.*)/") or "./"
	local repository_path = sf("%s../../..", this_directory)
	local library_path = sf("%s/lib/lua", repository_path)

	-- constructing a `package.path` to enable requiring from the
	-- dotfile manager directory or the central repository lib.
	package.path = sf(
		"%s;%s/?/init.lua;%s/?.lua",
		package.path,
		library_path,
		library_path
	)
end

local assertx = require("assertx")
local assert = assert

local ITERATIONS = 20000000

---This is a function that concatenates all of its arguments and
---returns the result.
local function concat(...)
	return table.concat({ ... })
end

local function bench(signature, func)
	local start = os.clock()

	for i = 1, ITERATIONS do
		func(i)
	end

	print(string.format("%s: %s", signature, os.clock() - start))
end

bench("assertx(true, table.concat({ 'blah', i }))", function(i)
	assertx(true, table.concat({ "blah", i }))
end)

bench(
	"assertx(true, function() return table.concat({'blah', i}) end)",
	function(i)
		assertx(true, function()
			return table.concat({ "blah", i })
		end)
	end
)

bench("assertx(true, concat, 'blah', i)", function(i)
	assertx(true, concat, "blah", i)
end)

bench("assert(true, table.concat({ 'blah', i }))", function(i)
	assert(true, table.concat({ "blah", i }))
end)
