local flip = require("f.function.flip")

describe("function", function()
	describe("flip()", function()
		it(
			"should return a function taking the original function's parameters flipped",
			function()
				local f = function(a, b)
					return a - #b
				end
				assert.same(-1, flip(f)("foo", 2))
			end
		)
	end)
end)
