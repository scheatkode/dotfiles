local is_empty = require("tablex.is_empty")

describe("tablex", function()
	describe("is_empty", function()
		it("should throw an error when given nil", function()
			---Necessary for testing.
			---@diagnostic disable-next-line: param-type-mismatch
			assert.error(function()
				is_empty(nil)
			end)
		end)

		it("should throw an error when given a number", function()
			---Necessary for testing.
			---@diagnostic disable-next-line: param-type-mismatch
			assert.error(function()
				is_empty(1)
			end)
		end)

		it("should throw an error when given a string", function()
			---Necessary for testing.
			---@diagnostic disable-next-line: param-type-mismatch
			assert.error(function()
				is_empty("abc")
			end)
		end)

		it("should throw an error when given a function", function()
			---Necessary for testing.
			---@diagnostic disable-next-line: param-type-mismatch
			assert.error(function()
				is_empty(function() end)
			end)
		end)

		it("should be truthy when given an empty table", function()
			assert.same(true, is_empty({}))
		end)

		it("should be falsy when given a non-empty table", function()
			assert.same(false, is_empty({ 1, 2, 3 }))
		end)

		it("should be falsy when given a non-empty hash-like table", function()
			assert.same(false, is_empty({ a = 1, b = 2, c = 3 }))
		end)
	end)
end)
