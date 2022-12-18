local fmt = string.format

local f   = require('f')
local add = require('f.operator.add')

describe('arithmetic operator', function()
	describe('add()', function()
		f.zip(f.random(0, 1000):take(100), f.random(0, 1000):take(100))
			:foreach(function(x, y)
				it(fmt('should add %3d and %3d', x, y), function()
					assert.are.same(x + y, add(x, y))
				end)
			end)
	end)
end)
