local fmt = string.format

local f = require("f")
local identity = require("f.function.identity")

describe("function", function()
	describe("identity()", function()
		f.zip(f.range(1, 50, 1), f.random(0, 1000):take(50))
			:take(50)
			:foreach(function(i)
				it(fmt("should return its parameter (#%02d)", i), function()
					assert.are.same(i, identity(i))
				end)
			end)

		f.zip(
			f.range(1, 50, 1),
			f.random(0, 1000):take(50),
			f.random(0, 1000):take(50),
			f.random(0, 1000):take(50),
			f.random(0, 1000):take(50),
			f.random(0, 1000):take(50),
			f.random(0, 1000):take(50),
			f.random(0, 1000):take(50),
			f.random(0, 1000):take(50),
			f.random(0, 1000):take(50),
			f.random(0, 1000):take(50)
		):foreach(function(i, ...)
			local args = { ... }

			it(fmt('should return its parameters "n-arily" #%02d', i), function()
				assert.are.same(args, { identity(unpack(args)) })
			end)
		end)
	end)
end)
