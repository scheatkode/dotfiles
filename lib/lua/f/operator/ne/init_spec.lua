local fmt = string.format

local f  = require('f')
local ne = require('f.operator.ne')

describe('operator', function()
	describe('ne()', function()
		it('should return false when x == y', function()
			assert.is_false(ne(2, 2))
		end)

		it('should return false when x == y', function()
			assert.is_false(ne('foo', 'foo'))
		end)

		it('should return true when x ≠ y', function()
			assert.is_true(ne(3, 2))
		end)

		it('should return true when x ≠ y', function()
			assert.is_true(ne('foo', 'bar'))
		end)

		f.zip(f.random(0, 1000):take(100), f.random(0, 1000):take(100))
			:foreach(function(x, y)
				it(fmt('should compare %3d and %3d', x, y), function()
					assert.are.same(x ~= y, ne(x, y))
				end)
			end)
	end)
end)
