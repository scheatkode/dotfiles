local fmt = string.format

local f    = require('f')
local land = require('f.operator.land')

describe('logical operator', function()
	describe('land()', function()
		local function tobool(x)
			return x == 1
		end

		f.zip(f.random(0, 1):take(100), f.random(0, 1):take(100))
			:foreach(function(x, y)
				x = tobool(x)
				y = tobool(y)

				it(
					fmt('should apply a logical and on %s and %s', x, y),
					function()
						assert.are.same(x and y, land(x, y))
					end
				)
			end)
	end)
end)
