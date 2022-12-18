local fmt = string.format

local f   = require('f')
local mod = require('f.operator.mod')

describe('arithmetic operator', function()
	describe('mod()', function()
		f.zip(f.random(0, 1000):take(100), f.random(0, 1000):take(100))
			:foreach(function(x, y)
				it(fmt('should return the modulo of %3d by %3d', x, y), function()
					assert.are.same(x % y, mod(x, y))
				end)
			end)
	end)
end)
