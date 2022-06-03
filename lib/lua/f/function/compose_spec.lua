local compose = require('f.function.compose')

describe('function', function()
	describe('compose()', function()
		local e = function(n) return n + 1 end
		local g = function(n) return n * 2 end
		local h = function(...)
			local result = 0

			for i = 1, select('#', ...) do
				result = result + select(i, ...)
			end

			return result
		end

		it('should compose  1 unary function',  function() assert.same(3,    compose(e)(2)) end)
		it('should compose  2 unary functions', function() assert.same(6,    compose(e, g)(2)) end)
		it('should compose  3 unary functions', function() assert.same(7,    compose(e, g, e)(2)) end)
		it('should compose  4 unary functions', function() assert.same(14,   compose(e, g, e, g)(2)) end)
		it('should compose  5 unary functions', function() assert.same(15,   compose(e, g, e, g, e)(2)) end)
		it('should compose  6 unary functions', function() assert.same(30,   compose(e, g, e, g, e, g)(2)) end)
		it('should compose  7 unary functions', function() assert.same(31,   compose(e, g, e, g, e, g, e)(2)) end)
		it('should compose  8 unary functions', function() assert.same(62,   compose(e, g, e, g, e, g, e, g)(2)) end)
		it('should compose  9 unary functions', function() assert.same(63,   compose(e, g, e, g, e, g, e, g, e)(2)) end)
		it('should compose 10 unary functions', function() assert.same(126,  compose(e, g, e, g, e, g, e, g, e, g)(2)) end)
		it('should compose 11 unary functions', function() assert.same(127,  compose(e, g, e, g, e, g, e, g, e, g, e)(2)) end)
		it('should compose 12 unary functions', function() assert.same(254,  compose(e, g, e, g, e, g, e, g, e, g, e, g)(2)) end)
		it('should compose 13 unary functions', function() assert.same(255,  compose(e, g, e, g, e, g, e, g, e, g, e, g, e)(2)) end)
		it('should compose 14 unary functions', function() assert.same(510,  compose(e, g, e, g, e, g, e, g, e, g, e, g, e, g)(2)) end)
		it('should compose 15 unary functions', function() assert.same(511,  compose(e, g, e, g, e, g, e, g, e, g, e, g, e, g, e)(2)) end)
		it('should compose 16 unary functions', function() assert.same(1022, compose(e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g)(2)) end)
		it('should compose 17 unary functions', function() assert.same(1023, compose(e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e)(2)) end)
		it('should compose 18 unary functions', function() assert.same(2046, compose(e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g)(2)) end)
		it('should compose 19 unary functions', function() assert.same(2047, compose(e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e)(2)) end)
		it('should compose 20 unary functions', function() assert.same(4094, compose(e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g)(2)) end)
		it('should compose 21 unary functions', function() assert.same(4095, compose(e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e)(2)) end)

		it('should compose  1 function',  function() assert.same(3,    compose(h)(1, 2)) end)
		it('should compose  2 functions', function() assert.same(6,    compose(h, g)(1, 2)) end)
		it('should compose  3 functions', function() assert.same(7,    compose(h, g, e)(1, 2)) end)
		it('should compose  4 functions', function() assert.same(14,   compose(h, g, e, g)(1, 2)) end)
		it('should compose  5 functions', function() assert.same(15,   compose(h, g, e, g, e)(1, 2)) end)
		it('should compose  6 functions', function() assert.same(30,   compose(h, g, e, g, e, g)(1, 2)) end)
		it('should compose  7 functions', function() assert.same(31,   compose(h, g, e, g, e, g, e)(1, 2)) end)
		it('should compose  8 functions', function() assert.same(62,   compose(h, g, e, g, e, g, e, g)(1, 2)) end)
		it('should compose  9 functions', function() assert.same(63,   compose(h, g, e, g, e, g, e, g, e)(1, 2)) end)
		it('should compose 10 functions', function() assert.same(126,  compose(h, g, e, g, e, g, e, g, e, g)(1, 2)) end)
		it('should compose 11 functions', function() assert.same(127,  compose(h, g, e, g, e, g, e, g, e, g, e)(1, 2)) end)
		it('should compose 12 functions', function() assert.same(254,  compose(h, g, e, g, e, g, e, g, e, g, e, g)(1, 2)) end)
		it('should compose 13 functions', function() assert.same(255,  compose(h, g, e, g, e, g, e, g, e, g, e, g, e)(1, 2)) end)
		it('should compose 14 functions', function() assert.same(510,  compose(h, g, e, g, e, g, e, g, e, g, e, g, e, g)(1, 2)) end)
		it('should compose 15 functions', function() assert.same(511,  compose(h, g, e, g, e, g, e, g, e, g, e, g, e, g, e)(1, 2)) end)
		it('should compose 16 functions', function() assert.same(1022, compose(h, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g)(1, 2)) end)
		it('should compose 17 functions', function() assert.same(1023, compose(h, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e)(1, 2)) end)
		it('should compose 18 functions', function() assert.same(2046, compose(h, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g)(1, 2)) end)
		it('should compose 19 functions', function() assert.same(2047, compose(h, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e)(1, 2)) end)
		it('should compose 20 functions', function() assert.same(4094, compose(h, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g)(1, 2)) end)
		it('should compose 21 functions', function() assert.same(4095, compose(h, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e)(1, 2)) end)
	end)
end)
