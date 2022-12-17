local constant   = require('f.function.constant')
local predicates = require('f.function.predicates')

describe('function', function()
	describe('predicates', function()
		it('should combine predicates into a single function', function()
			assert.is_true(predicates(constant(true), constant(true))())
			assert.is_false(predicates(constant(true), constant(false))())
		end)
	end)
end)
