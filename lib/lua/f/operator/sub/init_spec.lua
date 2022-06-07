local fmt = string.format

local f   = require('f')
local sub = require('f.operator.sub')

describe('arithmetic operator', function()
	describe('sub()', function()
		f.zip(
			f.random(0, 1000):take(100),
			f.random(0, 1000):take(100)
		)
			:foreach(function(x, y)
				it(fmt('should substract %3d from %3d', y, x), function()
					assert.are.same(x - y, sub(x, y))
				end)
			end)
	end)
end)
