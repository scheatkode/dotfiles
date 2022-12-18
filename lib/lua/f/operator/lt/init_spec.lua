local fmt = string.format

local f  = require('f')
local lt = require('f.operator.lt')

describe('comparison operator', function()
	describe('lt()', function()
		it('should return true when x < y', function()
			assert.is_true(lt(1, 2))
		end)

		it('should return false when x == y', function()
			assert.is_false(lt(2, 2))
		end)

		it('should return false when x > y', function()
			assert.is_false(lt(3, 2))
		end)

		f.zip(f.random(0, 1000):take(100), f.random(0, 1000):take(100))
			:foreach(function(x, y)
				it(fmt('should compare %3d and %3d', x, y), function()
					assert.are.same(x < y, lt(x, y))
				end)
			end)
	end)
end)
