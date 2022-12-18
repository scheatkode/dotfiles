local fmt = string.format

local f   = require('f')
local neg = require('f.operator.neg')

describe('arithmetic operator', function()
	describe('neg()', function()
		f.random(-1000, 1000):take(100):foreach(function(x)
			it(fmt('should return the negate %3d', x), function()
				assert.are.same(-x, neg(x))
			end)
		end)
	end)
end)
