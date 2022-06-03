local identity = require('f.function.identity')

describe('function', function()
	describe('identity()', function()
		for i = 1, 50 do
			it('should return its parameter #' .. i, function()
				assert.same(i, identity(i))
			end)
		end
	end)
end)
