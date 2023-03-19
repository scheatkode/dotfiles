local assertx = require("assertx")

describe("fast assertion", function()
	it("should only evaluate the first parameter", function()
		local call_count = 0

		assertx(true, function()
			call_count = call_count + 1
		end)
		assert.equal(call_count, 0)
	end)

	it("should evaluate the second parameter if the first is falsy", function()
		local call_count = 0

		local func1 = function()
			assertx(false, function()
				call_count = call_count + 1
			end)
		end
		local func2 = function()
			assertx(nil, function()
				call_count = call_count + 1
			end)
		end

		assert.error(func1)
		assert.error(func2)

		assert.equal(call_count, 2)
	end)

	it("should work repeatedly", function()
		local call_count = 0
		local func = function()
			call_count = call_count + 1
		end
		local err = function()
			assertx(false, func)
		end

		assertx(true, func)
		assertx(true, func)

		assert.error(err)
		assert.error(err)

		assertx(true, func)
		assertx(true, func)

		assert.equal(call_count, 2)
	end)

	it(
		"should call the given function with the rest of the arguments as parameters",
		function()
			local func = function(a)
				assert.equal(a, 1337)
			end
			local err = function()
				assertx(false, func, 1337)
			end

			assert.error(err)
		end
	)
end)
