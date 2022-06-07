local add   = require('f.operator.add')
local curry = require('f.function.curry')

describe('function', function()
	describe('curry()', function()
		local add3 = function (x, y, z) return x + y + z end
		local add4 = function (x, y, z, a) return x + y + z + a end

		it('should automatically curry a binary function', function()
			assert.are.same(6, curry(add)(2)(4))
		end)

		it('should automatically curry a ternary function', function()
			assert.are.same(14, curry(add3)(2)(4)(8))
		end)

		it('should automatically curry a quaternary function', function()
			assert.are.same(30, curry(add4)(2)(4)(8)(16))
		end)
	end)
end)
