local pack   = require('compat.table.pack')
local unpack = require('compat.table.unpack')

describe('compat', function()
	describe('table.pack()', function()
		it('should pack its arguments into a table with `n` field', function()
			local t = { 1, 2, 3 }

			assert.are.same({ n = 3, 1, 2, 3 }, pack(1, 2, 3))
			-- making sure
			assert.are.same(3, pack(1, 2, 3).n)
		end)
	end)

	describe('table.unpack()', function()
		it('should unpack the table into different variables', function()
			local x, y, z = unpack({ 1, 2, 3 })

			assert.are.same(x, 1)
			assert.are.same(y, 2)
			assert.are.same(z, 3)
		end)

		it(
			"should respect the arguments and unpack only what's asked",
			function()
				local x, y, z = unpack({ 5, 1, 2, 3 }, 2, 4)

				assert.are.same(x, 1)
				assert.are.same(y, 2)
				assert.are.same(z, 3)
			end
		)

		it('should respect the `n` field', function()
			local x, y, z, a, b = unpack({ n = 3, 1, 2, 3, 4, 5 })

			assert.are.same(x, 1)
			assert.are.same(y, 2)
			assert.are.same(z, 3)
			assert.is_nil(a)
			assert.is_nil(b)
		end)
	end)
end)
