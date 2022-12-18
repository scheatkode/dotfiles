local fmt = string.format

local f      = require('f')
local ltruth = require('f.operator.ltruth')

describe('logical operator', function()
	describe('ltruth()', function()
		local function tobool(x)
			return x == 1
		end

		f.random(0, 1):take(100):map(tobool):foreach(function(x)
			it(fmt('should apply a logical truth on %s', x), function()
				assert.are.same(not not x, ltruth(x))
			end)
		end)
	end)
end)
