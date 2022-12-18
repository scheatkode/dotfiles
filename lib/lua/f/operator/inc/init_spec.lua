local fmt = string.format

local f   = require('f')
local inc = require('f.operator.inc')

describe('arithmetic operator', function()
	describe('inc()', function()
		f.random(0, 1000):take(100):foreach(function(x)
			it(fmt('should increment %3d', x), function()
				assert.are.same(x + 1, inc(x))
			end)
		end)
	end)
end)
