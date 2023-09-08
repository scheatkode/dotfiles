local filter = require("tablex.filter")

describe("tablex", function()
	describe("filter()", function()
		it("should filter an array correctly", function()
			local t = { 1, 2, 3, 4 }

			local l = filter(t, function(_, i)
				return i % 2 == 1
			end)

			assert.same(l, { 1, 3 })
		end)
	end)
end)
