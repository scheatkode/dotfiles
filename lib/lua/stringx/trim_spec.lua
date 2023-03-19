local trim = require("stringx.trim")

describe("stringx", function()
	describe("trim()", function()
		it("should do nothing when given a trimmed string", function()
			assert.are.equal("abc", trim("abc"))
		end)

		it("should trim the left side of the given string", function()
			assert.are.equal("abc", trim("   abc"))
		end)

		it("should trim the right side of the given string", function()
			assert.are.equal("abc", trim("abc   "))
		end)

		it("should trim both sides of the given string", function()
			assert.are.equal("abc", trim("   abc   "))
		end)

		it("should trim newlines", function()
			assert.are.equal(
				"abc",
				trim([[
				abc
			]])
			)
		end)

		it("should trim newlines and carriage returns", function()
			assert.are.equal(
				"abc",
				trim([[
				abc
			]])
			)
		end)

		it("should trim tabs", function()
			assert.are.equal("abc", trim([[	abc	]]))
		end)

		it("should not trim no-break spaces", function()
			assert.are_not.equal("abc", trim([[ abc ]]))
		end)
	end)
end)
