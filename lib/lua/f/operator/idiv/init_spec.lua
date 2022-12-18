local fmt   = string.format
local ceil  = math.ceil
local floor = math.floor

local f    = require('f')
local idiv = require('f.operator.idiv')

describe('arithmetic operator', function()
	describe('idiv()', function()
		f.zip(f.random(0, 1000):take(100), f.random(0, 1000):take(100))
			:foreach(function(x, y)
				it(
					fmt('should divide %3d by %3d and floor the result', x, y),
					function()
						assert.are.same(floor(x / y), idiv(x, y))
					end
				)
			end)

		f.zip(f.random(-1000, 0):take(100), f.random(0, 1000):take(100))
			:foreach(function(x, y)
				it(
					fmt('should divide %4d by %4d and ceil the result', x, y),
					function()
						assert.are.same(ceil(x / y), idiv(x, y))
					end
				)
			end)

		f.zip(f.random(-1000, 0):take(100), f.random(-1000, 0):take(100))
			:foreach(function(x, y)
				it(
					fmt('should divide %4d by %4d and ceil the result', x, y),
					function()
						assert.are.same(floor(x / y), idiv(x, y))
					end
				)
			end)
	end)
end)
