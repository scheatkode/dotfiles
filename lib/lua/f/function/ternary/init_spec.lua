local fmt = string.format

local f = require("f")
local constant = require("f.function.constant")
local ternary = require("f.function.ternary")

describe("function", function()
	describe("ternary", function()
		f.zip(
			f.random(0, 1000):take(50),
			f.random(0, 1000):take(50),
			f.random(0, 1000):take(50)
		):foreach(function(condition, if_true, if_false)
			it(
				fmt(
					"should return %3d if %3d is odd or %3d otherwise",
					if_true,
					condition,
					if_false
				),
				function()
					local cond = (condition % 2) == 1
					local result = cond and if_true or if_false

					assert.are.same(
						result,
						ternary(cond, constant(if_true), constant(if_false))
					)
				end
			)
		end)
	end)
end)
