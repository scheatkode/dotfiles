local fmt = string.format

local f = require("f")
local ge = require("f.operator.ge")

describe("comparison operator", function()
	describe("ge()", function()
		it("should return true when x > y", function()
			assert.is_true(ge(2, 1))
		end)

		it("should return true when x == y", function()
			assert.is_true(ge(2, 2))
		end)

		it("should return false when x < y", function()
			assert.is_false(ge(2, 3))
		end)

		f.zip(f.random(0, 1000):take(100), f.random(0, 1000):take(100))
			:foreach(function(x, y)
				it(fmt("should compare %3d and %3d", x, y), function()
					assert.are.same(x >= y, ge(x, y))
				end)
			end)
	end)
end)
