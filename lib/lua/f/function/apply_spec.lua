local sf = string.format

local apply = require('f.function.apply')
local pipe  = require('f.function.pipe')

describe('function', function()
	describe('apply()', function()
		local function double(x) return x * 2 end

		for i = 1, 50 do
			it(sf('should apply a function to the parameter #%d', i), function()
				assert.same(double(i), pipe(double, apply(i)))
			end)
		end
	end)
end)
