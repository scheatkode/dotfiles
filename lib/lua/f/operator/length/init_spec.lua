local fmt = string.format

local f      = require('f')
local length = require('f.operator.length')
local gen    = require('arbitrary.string')

local fgen = f.wrap(function(_, _) return 0, gen() end, 0, 0)

describe('sequence operator', function()
	describe('length()', function()
		fgen
			:take(100)
			:foreach(function(x)
				it(fmt('should return the length of "%s"', x), function()
					assert.are.same(#x, length(x))
				end)
			end)
	end)
end)
