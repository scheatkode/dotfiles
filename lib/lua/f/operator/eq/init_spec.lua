local fmt = string.format

local f  = require('f')
local eq = require('f.operator.eq')

describe('comparison operator', function()
	describe('eq()', function()
		it('should return true when x == y', function()
			assert.is_true(eq(2, 2))
		end)

		it('should return true when x == y', function()
			assert.is_true(eq('foo', 'foo'))
		end)

		it('should return false when x ≠ y', function()
			assert.is_false(eq(3, 2))
		end)

		it('should return false when x ≠ y', function()
			assert.is_false(eq('foo', 'bar'))
		end)

		f.zip(
			f.random(0, 1000):take(100),
			f.random(0, 1000):take(100)
		)
			:foreach(function(x, y)
				it(fmt('should compare %3d and %3d', x, y), function()
					assert.are.same(x == y, eq(x, y))
				end)
			end)
	end)
end)
