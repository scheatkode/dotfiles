local fmt = string.format

local f = require("f")
local lnot = require("f.operator.lnot")

describe("logical operator", function()
	describe("lnot()", function()
		local function tobool(x)
			return x == 1
		end

		f.random(0, 1):take(100):map(tobool):foreach(function(x)
			it(fmt("should apply a logical not on %s", x), function()
				assert.are.same(not x, lnot(x))
			end)
		end)
	end)
end)
