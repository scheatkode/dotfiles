local separator = require('compat.separator')

describe('compat', function()
	describe('separator', function()
		it('should be either `/` or `\\`', function()
			assert.is_true(separator == '/' or separator == '\\')
		end)

		if vim then
			if vim.fn.has('win32') == 1 then
				it('should be `\\` because Windows', function()
					assert.is_true(separator == '\\')
				end)
			else
				it('should be `/`', function()
					assert.is_true(separator == '/')
				end)
			end
		end
	end)
end)
