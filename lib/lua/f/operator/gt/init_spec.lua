local fmt = string.format

local f  = require('f')
local gt = require('f.operator.gt')

describe('comparison operator', function()
	describe('gt()', function()
		it('should return true when x > y', function()
			assert.is_true(gt(2, 1))
		end)

		it('should return false when x == y', function()
			assert.is_false(gt(2, 2))
		end)

		it('should return false when x < y', function()
			assert.is_false(gt(2, 3))
		end)

		f.zip(
			f.random(0, 1000):take(100),
			f.random(0, 1000):take(100)
		)
			:foreach(function(x, y)
			   it(fmt('should compare %3d and %3d', x, y), function()
			      assert.are.same(x > y, gt(x, y))
			   end)
			end)
	end)
end)
