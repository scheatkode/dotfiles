local fmt = string.format

local f = require("f")
local pow = require("f.operator.pow")

describe("arithmetic operator", function()
	describe("pow()", function()
		f.zip(f.random(0, 1000):take(100), f.random(0, 1000):take(100))
			:foreach(function(x, y)
				it(fmt("should raise %3d to the power of %3d", x, y), function()
					assert.are.same(x ^ y, pow(x, y))
				end)
			end)
	end)
end)
