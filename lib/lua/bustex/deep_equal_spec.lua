require("bustex.deep_equal")

describe("busted extensions", function()
	describe("deep_equal", function()
		it("should directly compare non-table types", function()
			assert.deep_equal(1, 1)
			assert.deep_equal("a", "a")

			assert.not_deep_equal(1, 2)
			assert.not_deep_equal("a", "b")
		end)

		it("should compare simple lists", function()
			assert.deep_equal({ 1, 2, 3 }, { 1, 2, 3 })
			assert.deep_equal({ "a", "b", "c" }, { "a", "b", "c" })

			assert.not_deep_equal({ 1, 2, 3 }, { 2, 2, 3 })
			assert.not_deep_equal({ "a", "b", "c" }, { "b", "b", "c" })
		end)

		it("should compare simple hash-like tables", function()
			assert.deep_equal({ a = 1, b = 2 }, { a = 1, b = 2 })

			assert.not_deep_equal({ a = 1, b = 2 }, { a = 2, b = 2 })
			assert.not_deep_equal({ a = 1, b = 2 }, { a = 1, b = 2, c = 3 })
		end)

		it("should compare hybrid tables", function()
			assert.deep_equal({ 1, 2, a = "foo" }, { 1, 2, a = "foo" })

			assert.not_deep_equal({ 1, 2, a = "foo" }, { 1, a = "foo" })
			assert.not_deep_equal({ 1, 2, a = "foo" }, { 1, 2, a = "baz" })
			assert.not_deep_equal({ 1, 2, a = "foo" }, { 1, 2 })
		end)

		it("should compare nested tables", function()
			assert.deep_equal(
				{ 1, a = { b = 1 }, c = 1 },
				{ 1, a = { b = 1 }, c = 1 }
			)

			assert.not_deep_equal(
				{ 1, a = { b = 1 }, c = 1 },
				{ a = { b = 1 }, c = 1 }
			)
			assert.not_deep_equal(
				{ 1, a = { b = 1 }, c = 1 },
				{ 1, a = { b = 2 }, c = 1 }
			)
			assert.not_deep_equal(
				{ 1, a = { 1 }, c = 1 },
				{ 1, a = { b = 2 }, c = 1 }
			)
		end)

		it("should compare unsorted tables", function()
			assert.deep_equal({ 1, 2, 3 }, { 2, 1, 3 }, true)
			assert.not_deep_equal({ 1, 2, 3 }, { 2, 1, 3 })
		end)
	end)
end)
