local sf = string.format

local decrement = require('f.function.decrement')

describe('function', function()
	describe('decrement()', function()
		for i = -50, 50 do
			it(sf('given %3d, should return %3d', i, i - 1), function()
				assert.same(i - 1, decrement(i))
			end)
		end
	end)
end)
