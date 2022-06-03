local sf = string.format

local increment = require('f.function.increment')

describe('function', function()
	describe('increment()', function()
		for i = -50, 50 do
			it(sf('given %3d, should return %3d', i, i + 1), function()
				assert.same(i + 1, increment(i))
			end)
		end
	end)
end)
