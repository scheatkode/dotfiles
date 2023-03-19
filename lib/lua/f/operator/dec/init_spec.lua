local fmt = string.format

local f = require("f")
local dec = require("f.operator.dec")

describe("arithmetic operator", function()
	describe("dec()", function()
		f.random(0, 1000):take(100):foreach(function(x)
			it(fmt("should decrement %3d", x), function()
				assert.are.same(x - 1, dec(x))
			end)
		end)
	end)
end)
