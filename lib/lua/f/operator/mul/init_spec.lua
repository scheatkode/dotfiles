local fmt = string.format

local f   = require('f')
local mul = require('f.operator.mul')

describe('arithmetic operator', function()
	describe('mul()', function()
		f.zip(f.random(0, 1000):take(100), f.random(0, 1000):take(100))
			:foreach(function(x, y)
				it(fmt('should return the multiply %3d by %3d', x, y), function()
					assert.are.same(x * y, mul(x, y))
				end)
			end)
	end)
end)
