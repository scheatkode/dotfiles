local memo = require('f.function.memoize')

describe('function', function()
	describe('memoize', function()
		local counter
		local memoized

		local count = function()
			counter = counter + 1
			return counter
		end

		before_each(function()
			counter = 0
			memoized = memo(count)
		end)

		it('should accept no parameters', function()
			memoized()
			assert.are.same(1, memoized())
			assert.are.same(1, counter)
		end)

		it('should accept 1 parameter', function()
			memoized('foo')
			assert.are.same(1, memoized('foo'))
			assert.are.same(2, memoized('bar'))
			assert.are.same(1, memoized('foo'))
			assert.are.same(2, memoized('bar'))
			assert.are.same(2, counter)
		end)

		it('should accept 2 parameters', function()
			memoized('foo', 'bar')
			assert.are.same(1, memoized('foo', 'bar'))
			assert.are.same(2, memoized('foo', 'baz'))
			assert.are.same(1, memoized('foo', 'bar'))
			assert.are.same(2, memoized('foo', 'baz'))
			assert.are.same(2, counter)
		end)

		it('should accept tables and functions', function()
			local t1 = {}
			local t2 = {}

			assert.are.same(1, memoized(print, t1))
			assert.are.same(2, memoized(print, t2))
			assert.are.same(1, memoized(print, t1))
			assert.are.same(2, memoized(print, t2))
			assert.are.same(2, counter)
		end)

		it('should handle returning multiple values', function()
			local flip = memo(function(x, y)
				counter = counter + 1
				return y, x
			end)

			local memo_flip = memo(flip)
			local x, y = memo_flip(1, 2)

			assert.same(2, x)
			assert.same(1, y)
			assert.same(1, counter)

			x, y = memo_flip(3, 4)

			assert.same(4, x)
			assert.same(3, y)
			assert.same(2, counter)

			x, y = memo_flip(1, 2)

			assert.same(2, x)
			assert.same(1, y)
			assert.same(2, counter)

			x, y = memo_flip(3, 4)

			assert.same(4, x)
			assert.same(3, y)
			assert.same(2, counter)
		end)

		it('should handle flipped arguments', function()
			local add = function(x, y)
				counter = counter + 1
				return x + y
			end

			local memo_add = memo(add)

			assert.same(5, memo_add(2, 3))
			assert.same(5, memo_add(3, 2))

			assert.same(2, counter)
		end)
	end)
end)
