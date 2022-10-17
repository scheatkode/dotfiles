local deep_extend = require('tablex.deep_extend')

describe('tablex', function()
	describe('deep_extend', function()
		it('should throw an error when given an invalid behavior', function()
			assert.error(deep_extend)
		end)

		it('should throw an error when no table is given', function()
			assert.error(function() deep_extend('keep') end)
		end)

		it('should throw an error when only one table is given', function()
			assert.error(function() deep_extend('keep', {}) end)
		end)

		describe('with keeping behavior', function()
			it('should extend two tables without overwriting existing elements', function()
				local a = { x = { a = 1, b = 2 } }
				local b = { x = { a = 2, c = { y = 3 } } }

				local actual   = deep_extend('keep', a, b)
				local expected = { x = { a = 1, b = 2, c = { y = 3 } } }

				assert.same(expected, actual)
			end)

			it('should extend three tables without overwriting existing elements', function()
				local a = { x = { a = 1, b = 2 } }
				local b = { x = { a = 2, c = { y = 3 } } }
				local c = { x = { c = 4, d = { y = 4 } } }

				local actual   = deep_extend('keep', a, b, c)
				local expected = { x = { a = 1, b = 2, c = { y = 3 }, d = { y = 4 } } }

				assert.same(expected, actual)
			end)
		end)

		describe('with forcing behavior', function()
			it('should extend two tables overwriting existing elements', function()
				local a = { x = { a = 1, b = 2 } }
				local b = { x = { a = 2, c = { y = 3 } } }

				local actual   = deep_extend('force', a, b)
				local expected = { x = { a = 2, b = 2, c = { y = 3 } } }

				assert.same(expected, actual)
			end)

			it('should extend three tables overwriting existing elements', function()
				local a = { x = { a = 1, b = 2 } }
				local b = { x = { a = 2, c = { y = 3 } } }
				local c = { x = { c = 4, d = { y = 4 } } }

				local actual   = deep_extend('force', a, b, c)
				local expected = { x = { a = 2, b = 2, c = 4, d = { y = 4 } } }

				assert.same(expected, actual)
			end)
		end)
	end)
end)
