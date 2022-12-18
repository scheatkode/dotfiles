local fmt = string.format

local f   = require('f')
local div = require('f.operator.div')

describe('arithmetic operator', function()
	describe('div()', function()
		f.zip(f.random(0, 1000):take(100), f.random(0, 1000):take(100))
			:foreach(function(x, y)
				it(fmt('should divide %3d by %3d', x, y), function()
					assert.are.same(x / y, div(x, y))
				end)
			end)
	end)
end)
