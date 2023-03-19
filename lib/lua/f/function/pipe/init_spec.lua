local pipe = require("f.function.pipe")
local pipe_nary = require("f.function.pipe.nary")

describe("function", function()
	describe("pipe()", function()
		local e = function(n)
			return n + 1
		end
		local g = function(n)
			return n * 2
		end

		it("should return the given parameter", function()
			assert.same(2, pipe(2))
		end)

		it("should pipe  1 function", function()
			assert.same(3, pipe(2, e))
		end)
		it("should pipe  2 functions", function()
			assert.same(6, pipe(2, e, g))
		end)
		it("should pipe  3 functions", function()
			assert.same(7, pipe(2, e, g, e))
		end)
		it("should pipe  4 functions", function()
			assert.same(14, pipe(2, e, g, e, g))
		end)
		it("should pipe  5 functions", function()
			assert.same(15, pipe(2, e, g, e, g, e))
		end)
		it("should pipe  6 functions", function()
			assert.same(30, pipe(2, e, g, e, g, e, g))
		end)
		it("should pipe  7 functions", function()
			assert.same(31, pipe(2, e, g, e, g, e, g, e))
		end)
		it("should pipe  8 functions", function()
			assert.same(62, pipe(2, e, g, e, g, e, g, e, g))
		end)
		it("should pipe  9 functions", function()
			assert.same(63, pipe(2, e, g, e, g, e, g, e, g, e))
		end)
		it("should pipe 10 functions", function()
			assert.same(126, pipe(2, e, g, e, g, e, g, e, g, e, g))
		end)
		it("should pipe 11 functions", function()
			assert.same(127, pipe(2, e, g, e, g, e, g, e, g, e, g, e))
		end)
		it("should pipe 12 functions", function()
			assert.same(254, pipe(2, e, g, e, g, e, g, e, g, e, g, e, g))
		end)
		it("should pipe 13 functions", function()
			assert.same(255, pipe(2, e, g, e, g, e, g, e, g, e, g, e, g, e))
		end)
		it("should pipe 14 functions", function()
			assert.same(510, pipe(2, e, g, e, g, e, g, e, g, e, g, e, g, e, g))
		end)
		it("should pipe 15 functions", function()
			assert.same(
				511,
				pipe(2, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e)
			)
		end)
		it("should pipe 16 functions", function()
			assert.same(
				1022,
				pipe(2, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g)
			)
		end)
		it("should pipe 17 functions", function()
			assert.same(
				1023,
				pipe(2, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e)
			)
		end)
		it("should pipe 18 functions", function()
			assert.same(
				2046,
				pipe(2, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g)
			)
		end)
		it("should pipe 19 functions", function()
			assert.same(
				2047,
				pipe(2, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e)
			)
		end)
		it("should pipe 20 functions", function()
			assert.same(
				4094,
				pipe(
					2,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g
				)
			)
		end)
		it("should pipe 21 functions", function()
			assert.same(
				4095,
				pipe(
					2,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e
				)
			)
		end)
	end)

	describe("pipe_nary()", function()
		local e = function(n)
			return n + 1
		end
		local g = function(n)
			return n * 2
		end

		local d = function(x)
			return x, x
		end -- duplicate

		local h = function(x, y)
			return x + y
		end
		local j = function(x, y)
			return x * y
		end

		it("should return the given parameter", function()
			assert.same(2, pipe(2))
		end)

		it("should pipe  1 unary function", function()
			assert.same(3, pipe_nary(2, e))
		end)
		it("should pipe  2 unary functions", function()
			assert.same(6, pipe_nary(2, e, g))
		end)
		it("should pipe  3 unary functions", function()
			assert.same(7, pipe_nary(2, e, g, e))
		end)
		it("should pipe  4 unary functions", function()
			assert.same(14, pipe_nary(2, e, g, e, g))
		end)
		it("should pipe  5 unary functions", function()
			assert.same(15, pipe_nary(2, e, g, e, g, e))
		end)
		it("should pipe  6 unary functions", function()
			assert.same(30, pipe_nary(2, e, g, e, g, e, g))
		end)
		it("should pipe  7 unary functions", function()
			assert.same(31, pipe_nary(2, e, g, e, g, e, g, e))
		end)
		it("should pipe  8 unary functions", function()
			assert.same(62, pipe_nary(2, e, g, e, g, e, g, e, g))
		end)
		it("should pipe  9 unary functions", function()
			assert.same(63, pipe_nary(2, e, g, e, g, e, g, e, g, e))
		end)
		it("should pipe 10 unary functions", function()
			assert.same(126, pipe_nary(2, e, g, e, g, e, g, e, g, e, g))
		end)
		it("should pipe 11 unary functions", function()
			assert.same(127, pipe_nary(2, e, g, e, g, e, g, e, g, e, g, e))
		end)
		it("should pipe 12 unary functions", function()
			assert.same(254, pipe_nary(2, e, g, e, g, e, g, e, g, e, g, e, g))
		end)
		it("should pipe 13 unary functions", function()
			assert.same(255, pipe_nary(2, e, g, e, g, e, g, e, g, e, g, e, g, e))
		end)
		it("should pipe 14 unary functions", function()
			assert.same(
				510,
				pipe_nary(2, e, g, e, g, e, g, e, g, e, g, e, g, e, g)
			)
		end)
		it("should pipe 15 unary functions", function()
			assert.same(
				511,
				pipe_nary(2, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e)
			)
		end)
		it("should pipe 16 unary functions", function()
			assert.same(
				1022,
				pipe_nary(2, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g)
			)
		end)
		it("should pipe 17 unary functions", function()
			assert.same(
				1023,
				pipe_nary(2, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e)
			)
		end)
		it("should pipe 18 unary functions", function()
			assert.same(
				2046,
				pipe_nary(2, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g)
			)
		end)
		it("should pipe 19 unary functions", function()
			assert.same(
				2047,
				pipe_nary(
					2,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e
				)
			)
		end)
		it("should pipe 20 unary functions", function()
			assert.same(
				4094,
				pipe_nary(
					2,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g
				)
			)
		end)
		it("should pipe 21 unary functions", function()
			assert.same(
				4095,
				pipe_nary(
					2,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e,
					g,
					e
				)
			)
		end)

		it("should pipe  2 n-ary function", function()
			assert.same(4, pipe_nary(2, d, h))
		end)
		it("should pipe  4 n-ary functions", function()
			assert.same(16, pipe_nary(2, d, h, d, j))
		end)
		it("should pipe  6 n-ary functions", function()
			assert.same(32, pipe_nary(2, d, h, d, j, d, h))
		end)
		it("should pipe  8 n-ary functions", function()
			assert.same(1024, pipe_nary(2, d, h, d, j, d, h, d, j))
		end)
		it("should pipe 10 n-ary functions", function()
			assert.same(2048, pipe_nary(2, d, h, d, j, d, h, d, j, d, h))
		end)
		it("should pipe 12 n-ary functions", function()
			assert.same(
				4194304,
				pipe_nary(2, d, h, d, j, d, h, d, j, d, h, d, j)
			)
		end)
		it("should pipe 14 n-ary functions", function()
			assert.same(
				8388608,
				pipe_nary(2, d, h, d, j, d, h, d, j, d, h, d, j, d, h)
			)
		end)
		it("should pipe 16 n-ary functions", function()
			assert.same(
				70368744177664,
				pipe_nary(2, d, h, d, j, d, h, d, j, d, h, d, j, d, h, d, j)
			)
		end)
		it("should pipe 18 n-ary functions", function()
			assert.same(
				140737488355328,
				pipe_nary(2, d, h, d, j, d, h, d, j, d, h, d, j, d, h, d, j, d, h)
			)
		end)
		it("should pipe 20 n-ary functions", function()
			assert.same(
				19807040628566084398385987584,
				pipe_nary(
					2,
					d,
					h,
					d,
					j,
					d,
					h,
					d,
					j,
					d,
					h,
					d,
					j,
					d,
					h,
					d,
					j,
					d,
					h,
					d,
					j
				)
			)
		end)
		it("should pipe 22 n-ary functions", function()
			assert.same(
				39614081257132168796771975168,
				pipe_nary(
					2,
					d,
					h,
					d,
					j,
					d,
					h,
					d,
					j,
					d,
					h,
					d,
					j,
					d,
					h,
					d,
					j,
					d,
					h,
					d,
					j,
					d,
					h
				)
			)
		end)
	end)
end)
