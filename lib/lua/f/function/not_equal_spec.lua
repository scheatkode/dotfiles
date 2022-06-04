local neq = require('f.function.not_equal')

describe('function', function()
	describe('not_equal()', function()
		it('should return false for equal values', function()
			assert.is_false(neq(123)(123))
		end)

		it('should return true for unequal values', function()
			assert.is_true(neq(123)(321))
		end)
	end)
end)
