local fmt = string.format

local f       = require('f')
local partial = require('f.function.partial')
local pipe    = require('f.function.pipe')

describe('function', function()
	describe('partial', function()
		local add = function(x, y) return x + y end
		local mul = function(x, y) return x * y end

		f.zip(
			f.random(0, 1000):take(50),
			f.random(0, 1000):take(50),
			f.random(0, 1000):take(50)
		)
			:foreach(function(adder, multiplier, number)
				it(fmt('should partially apply through the pipe such that (%3d + %3d) * %3d', number, adder, multiplier), function()
					assert.are.same(
						(number + adder) * multiplier,
						pipe(number, partial(add, adder), partial(mul, multiplier))
					)
				end)
			end)

		local discriminant = function(a, b, c)
			return b * b - 4 * a * c
		end

		f.zip(
			f.random(0, 1000):take(50),
			f.random(0, 1000):take(50),
			f.random(0, 1000):take(50)
		)
			:foreach(function(a, b, c)
				it(fmt('should partially apply the function with one argument (%3d, %3d, %3d)', a, b, c), function()
					assert.are.same(
						b * b - 4 * a * c,
						partial(discriminant, a)(b, c)
					)
				end)
			end)

		f.zip(
			f.random(0, 1000):take(50),
			f.random(0, 1000):take(50),
			f.random(0, 1000):take(50)
		)
			:foreach(function(a, b, c)
				it(fmt('should partially apply the function with multiple arguments (%3d, %3d, %3d)', a, b, c), function()
					assert.are.same(
						b * b - 4 * a * c,
						pipe(c, partial(discriminant, a, b))
					)
				end)
			end)
	end)
end)
