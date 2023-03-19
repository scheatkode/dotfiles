---This module strays off the beaten path of naively hashing or storing
---argument values as-is in a single table by abusing closures and
---recursion. This is done by building several implicit argument trees
---*inside* of the built closures, which are of course, tail-call
---optimized.

local select = select
local setmetatable = setmetatable

local pack = require("compat.table.pack")
local unpack = require("compat.table.unpack")

---Storing a closure is more memory and speed efficient than storing
---the actual return values in a cache table.
---@vararg any
---@return function
local function enclose(...)
	local v = pack(...)

	return function()
		return unpack(v)
	end
end

---Create a weak table.
---@return table
local function weak_table()
	return setmetatable({}, { __mode = "kv" })
end

local function return_or_empty(arg)
	return (arg == nil and {}) or arg
end

---Build a memoization function that can handle the 1-argument case.
---@param f function
---@return function
local function memoize_1(f)
	local lookup = weak_table()

	return function(arg)
		local k = return_or_empty(arg)
		local r = lookup[k]

		if r then
			return r()
		end

		r = enclose(f(arg))
		lookup[k] = r

		return r()
	end
end

---Build a memoization function that assumes `n` arguments.
---@param n number Number of arguments
---@param f function Function to memoize
---@return function m Memoized function
local function memoize_n(n, f)
	-- Handle the `0` case to avoid infinite loops and keep the general
	-- case simple.
	if n == 0 then
		local memoized

		return function()
			if memoized then
				return memoized()
			end

			memoized = enclose(f())
			return memoized()
		end
	end

	-- Small optimization for the `1` case since unary functions are most
	-- common.
	if n == 1 then
		return memoize_1(f)
	end

	-- Create a locally scoped implicit weak table for storing the
	-- arguments.
	local lookup = weak_table()

	-- Handle the general `n`-arguments case. return function(arg, ...)
	local m = function(arg, ...)
		local k = return_or_empty(arg)
		local r = lookup[k]

		if r then
			return r(...)
		end

		-- Create a new argument memoizer that will handle this argument
		-- value in the future.
		r = memoize_n(n - 1, function(...)
			return f(arg, ...)
		end)

		print(debug.getinfo(1, "n").istailcall)

		lookup[k] = r
		return r(...)
	end

	return m
end

---Given an expensive pure function `f`, cache the number of arguments
---and their values to speed up returning.
---@param f function Function to memoize
---@return function m Memoized function
local function memoize(f)
	local memoized = weak_table()

	return function(...)
		local n = select("#", ...)
		local mf = memoized[n]

		if mf then
			return mf(...)
		end

		mf = memoize_n(n, f)
		memoized[n] = mf

		return mf(...)
	end
end

return memoize
