local fmt   = string.format
local floor = math.floor

local f    = require('f')
local fdiv = require('f.operator.fdiv')

describe('arithmetic operator', function()
	describe('fdiv()', function()
		f.zip(f.random(0, 1000):take(100), f.random(0, 1000):take(100))
			:foreach(function(x, y)
				it(
					fmt('should divide %3d by %3d and floor the result', x, y),
					function()
						assert.are.same(floor(x / y), fdiv(x, y))
					end
				)
			end)
	end)
end)
