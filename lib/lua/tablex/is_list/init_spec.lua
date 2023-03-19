local is_list = require("tablex.is_list")

describe("tablex", function()
	describe("is_list", function()
		it("should be falsy when given nil", function()
			---Necessary for testing.
			---@diagnostic disable-next-line: param-type-mismatch
			assert.same(false, is_list(nil))
		end)

		it("should be falsy when given a number", function()
			---Necessary for testing.
			---@diagnostic disable-next-line: param-type-mismatch
			assert.same(false, is_list(1))
		end)

		it("should be falsy when given a string", function()
			---Necessary for testing.
			---@diagnostic disable-next-line: param-type-mismatch
			assert.same(false, is_list("abc"))
		end)

		it("should be falsy when given a function", function()
			---Necessary for testing.
			---@diagnostic disable-next-line: param-type-mismatch
			assert.same(false, is_list(function() end))
		end)

		it("should be truthy when given an empty table", function()
			assert.same(true, is_list({}))
		end)

		it("should be truthy when given a list of numbers", function()
			assert.same(true, is_list({ 1, 2, 3 }))
		end)

		it("should be truthy when given a list of strings", function()
			assert.same(true, is_list({ "a", "b", "c" }))
		end)

		it(
			"should be truthy when given a list of numbers and strings",
			function()
				assert.same(true, is_list({ 1, 2, "abc", "foo" }))
			end
		)

		it("should be falsy when given a hybrid table", function()
			assert.same(false, is_list({ 1, 2, "abc", a = "foo" }))
		end)

		it("should be falsy when given a hybrid table", function()
			assert.same(false, is_list({ a = "foo", 1, 2, "abc" }))
		end)
	end)
end)
