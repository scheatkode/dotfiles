local fmt = string.format

local f = require("f")
local constant = require("f.function.constant")

describe("function", function()
	describe("constant()", function()
		f.zip(f.range(1, 50, 1), f.random(0, 1000):take(50))
			:foreach(function(i, x)
				it(
					fmt(
						"should return a function than returns the original parameter (#%02d)",
						i
					),
					function()
						local p = constant(x)
						assert.same(x, p())
					end
				)
			end)
	end)
end)
