local sf = string.format

local apply     = require('f.function.apply')
local identity  = require('f.function.identity')
local flip      = require('f.function.flip')

local decrement = require('f.function.decrement')
local increment = require('f.function.increment')

local compose   = require('f.function.compose')
local pipe      = require('f.function.pipe')

describe('function', function ()
   describe('flip()', function ()
      it('should return a function taking the original function\'s parameters flipped', function ()
         local fu = function (a, b) return a - #b end
         assert.same(-1, flip(fu)('foo', 2))
      end)
   end)

   describe('identity()', function ()
      for i = 1, 50 do
         it('should return its parameter #' .. i, function ()
            assert.same(i, identity(i))
         end)
      end
   end)

   describe('increment()', function ()
      for i = -50, 50 do
         it(sf('given %3d, should return %3d', i, i + 1), function ()
            assert.same(i + 1, increment(i))
         end)
      end
   end)

   describe('decrement()', function ()
      for i = -50, 50 do
         it(sf('given %3d, should return %3d', i, i - 1), function ()
            assert.same(i - 1, decrement(i))
         end)
      end
   end)

   describe('flow()', function ()
      local e = function (n) return n + 1 end
      local g = function (n) return n * 2 end
      local h = function (...)
         local result = 0

         for i = 1, select('#', ...) do
            result = result + select(i, ...)
         end

         return result
      end

      it('should compose  1 unary function',  function () assert.same(3,    compose(e)(2)) end)
      it('should compose  2 unary functions', function () assert.same(6,    compose(e, g)(2)) end)
      it('should compose  3 unary functions', function () assert.same(7,    compose(e, g, e)(2)) end)
      it('should compose  4 unary functions', function () assert.same(14,   compose(e, g, e, g)(2)) end)
      it('should compose  5 unary functions', function () assert.same(15,   compose(e, g, e, g, e)(2)) end)
      it('should compose  6 unary functions', function () assert.same(30,   compose(e, g, e, g, e, g)(2)) end)
      it('should compose  7 unary functions', function () assert.same(31,   compose(e, g, e, g, e, g, e)(2)) end)
      it('should compose  8 unary functions', function () assert.same(62,   compose(e, g, e, g, e, g, e, g)(2)) end)
      it('should compose  9 unary functions', function () assert.same(63,   compose(e, g, e, g, e, g, e, g, e)(2)) end)
      it('should compose 10 unary functions', function () assert.same(126,  compose(e, g, e, g, e, g, e, g, e, g)(2)) end)
      it('should compose 11 unary functions', function () assert.same(127,  compose(e, g, e, g, e, g, e, g, e, g, e)(2)) end)
      it('should compose 12 unary functions', function () assert.same(254,  compose(e, g, e, g, e, g, e, g, e, g, e, g)(2)) end)
      it('should compose 13 unary functions', function () assert.same(255,  compose(e, g, e, g, e, g, e, g, e, g, e, g, e)(2)) end)
      it('should compose 14 unary functions', function () assert.same(510,  compose(e, g, e, g, e, g, e, g, e, g, e, g, e, g)(2)) end)
      it('should compose 15 unary functions', function () assert.same(511,  compose(e, g, e, g, e, g, e, g, e, g, e, g, e, g, e)(2)) end)
      it('should compose 16 unary functions', function () assert.same(1022, compose(e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g)(2)) end)
      it('should compose 17 unary functions', function () assert.same(1023, compose(e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e)(2)) end)
      it('should compose 18 unary functions', function () assert.same(2046, compose(e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g)(2)) end)
      it('should compose 19 unary functions', function () assert.same(2047, compose(e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e)(2)) end)
      it('should compose 20 unary functions', function () assert.same(4094, compose(e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g)(2)) end)
      it('should compose 21 unary functions', function () assert.same(4095, compose(e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e)(2)) end)

      it('should compose  1 function',  function () assert.same(3,    compose(h)(1, 2)) end)
      it('should compose  2 functions', function () assert.same(6,    compose(h, g)(1, 2)) end)
      it('should compose  3 functions', function () assert.same(7,    compose(h, g, e)(1, 2)) end)
      it('should compose  4 functions', function () assert.same(14,   compose(h, g, e, g)(1, 2)) end)
      it('should compose  5 functions', function () assert.same(15,   compose(h, g, e, g, e)(1, 2)) end)
      it('should compose  6 functions', function () assert.same(30,   compose(h, g, e, g, e, g)(1, 2)) end)
      it('should compose  7 functions', function () assert.same(31,   compose(h, g, e, g, e, g, e)(1, 2)) end)
      it('should compose  8 functions', function () assert.same(62,   compose(h, g, e, g, e, g, e, g)(1, 2)) end)
      it('should compose  9 functions', function () assert.same(63,   compose(h, g, e, g, e, g, e, g, e)(1, 2)) end)
      it('should compose 10 functions', function () assert.same(126,  compose(h, g, e, g, e, g, e, g, e, g)(1, 2)) end)
      it('should compose 11 functions', function () assert.same(127,  compose(h, g, e, g, e, g, e, g, e, g, e)(1, 2)) end)
      it('should compose 12 functions', function () assert.same(254,  compose(h, g, e, g, e, g, e, g, e, g, e, g)(1, 2)) end)
      it('should compose 13 functions', function () assert.same(255,  compose(h, g, e, g, e, g, e, g, e, g, e, g, e)(1, 2)) end)
      it('should compose 14 functions', function () assert.same(510,  compose(h, g, e, g, e, g, e, g, e, g, e, g, e, g)(1, 2)) end)
      it('should compose 15 functions', function () assert.same(511,  compose(h, g, e, g, e, g, e, g, e, g, e, g, e, g, e)(1, 2)) end)
      it('should compose 16 functions', function () assert.same(1022, compose(h, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g)(1, 2)) end)
      it('should compose 17 functions', function () assert.same(1023, compose(h, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e)(1, 2)) end)
      it('should compose 18 functions', function () assert.same(2046, compose(h, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g)(1, 2)) end)
      it('should compose 19 functions', function () assert.same(2047, compose(h, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e)(1, 2)) end)
      it('should compose 20 functions', function () assert.same(4094, compose(h, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g)(1, 2)) end)
      it('should compose 21 functions', function () assert.same(4095, compose(h, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e)(1, 2)) end)
   end)

   describe('pipe()', function ()
      local e = function (n) return n + 1 end
      local g = function (n) return n * 2 end

      it('should return the given parameter', function () assert.same(2, pipe(2)) end)

      it('should pipe  1 function',  function () assert.same(3,    pipe(2, e)) end)
      it('should pipe  2 functions', function () assert.same(6,    pipe(2, e, g)) end)
      it('should pipe  3 functions', function () assert.same(7,    pipe(2, e, g, e)) end)
      it('should pipe  4 functions', function () assert.same(14,   pipe(2, e, g, e, g)) end)
      it('should pipe  5 functions', function () assert.same(15,   pipe(2, e, g, e, g, e)) end)
      it('should pipe  6 functions', function () assert.same(30,   pipe(2, e, g, e, g, e, g)) end)
      it('should pipe  7 functions', function () assert.same(31,   pipe(2, e, g, e, g, e, g, e)) end)
      it('should pipe  8 functions', function () assert.same(62,   pipe(2, e, g, e, g, e, g, e, g)) end)
      it('should pipe  9 functions', function () assert.same(63,   pipe(2, e, g, e, g, e, g, e, g, e)) end)
      it('should pipe 10 functions', function () assert.same(126,  pipe(2, e, g, e, g, e, g, e, g, e, g)) end)
      it('should pipe 11 functions', function () assert.same(127,  pipe(2, e, g, e, g, e, g, e, g, e, g, e)) end)
      it('should pipe 12 functions', function () assert.same(254,  pipe(2, e, g, e, g, e, g, e, g, e, g, e, g)) end)
      it('should pipe 13 functions', function () assert.same(255,  pipe(2, e, g, e, g, e, g, e, g, e, g, e, g, e)) end)
      it('should pipe 14 functions', function () assert.same(510,  pipe(2, e, g, e, g, e, g, e, g, e, g, e, g, e, g)) end)
      it('should pipe 15 functions', function () assert.same(511,  pipe(2, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e)) end)
      it('should pipe 16 functions', function () assert.same(1022, pipe(2, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g)) end)
      it('should pipe 17 functions', function () assert.same(1023, pipe(2, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e)) end)
      it('should pipe 18 functions', function () assert.same(2046, pipe(2, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g)) end)
      it('should pipe 19 functions', function () assert.same(2047, pipe(2, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e)) end)
      it('should pipe 20 functions', function () assert.same(4094, pipe(2, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g)) end)
      it('should pipe 21 functions', function () assert.same(4095, pipe(2, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e)) end)
   end)

   describe('apply()', function ()
      local function double (x) return x * 2 end

      for i = 1, 50 do
         it(sf('should apply a function to the parameter #%d', i), function ()
            assert.same(double(i), pipe(double, apply(i)))
         end)
      end
   end)
end)
