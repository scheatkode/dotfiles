local sf = string.format

local apply     = require('f.function.apply')
local identity  = require('f.function.identity')
local flip      = require('f.function.flip')

local decrement = require('f.function.decrement')
local increment = require('f.function.increment')

local flow      = require('f.function.flow')
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

      it('should flow  1 unary function',  function () assert.same(3,    flow(e)(2)) end)
      it('should flow  2 unary functions', function () assert.same(6,    flow(e, g)(2)) end)
      it('should flow  3 unary functions', function () assert.same(7,    flow(e, g, e)(2)) end)
      it('should flow  4 unary functions', function () assert.same(14,   flow(e, g, e, g)(2)) end)
      it('should flow  5 unary functions', function () assert.same(15,   flow(e, g, e, g, e)(2)) end)
      it('should flow  6 unary functions', function () assert.same(30,   flow(e, g, e, g, e, g)(2)) end)
      it('should flow  7 unary functions', function () assert.same(31,   flow(e, g, e, g, e, g, e)(2)) end)
      it('should flow  8 unary functions', function () assert.same(62,   flow(e, g, e, g, e, g, e, g)(2)) end)
      it('should flow  9 unary functions', function () assert.same(63,   flow(e, g, e, g, e, g, e, g, e)(2)) end)
      it('should flow 10 unary functions', function () assert.same(126,  flow(e, g, e, g, e, g, e, g, e, g)(2)) end)
      it('should flow 11 unary functions', function () assert.same(127,  flow(e, g, e, g, e, g, e, g, e, g, e)(2)) end)
      it('should flow 12 unary functions', function () assert.same(254,  flow(e, g, e, g, e, g, e, g, e, g, e, g)(2)) end)
      it('should flow 13 unary functions', function () assert.same(255,  flow(e, g, e, g, e, g, e, g, e, g, e, g, e)(2)) end)
      it('should flow 14 unary functions', function () assert.same(510,  flow(e, g, e, g, e, g, e, g, e, g, e, g, e, g)(2)) end)
      it('should flow 15 unary functions', function () assert.same(511,  flow(e, g, e, g, e, g, e, g, e, g, e, g, e, g, e)(2)) end)
      it('should flow 16 unary functions', function () assert.same(1022, flow(e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g)(2)) end)
      it('should flow 17 unary functions', function () assert.same(1023, flow(e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e)(2)) end)
      it('should flow 18 unary functions', function () assert.same(2046, flow(e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g)(2)) end)
      it('should flow 19 unary functions', function () assert.same(2047, flow(e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e)(2)) end)
      it('should flow 20 unary functions', function () assert.same(4094, flow(e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g)(2)) end)
      it('should flow 21 unary functions', function () assert.same(4095, flow(e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e)(2)) end)

      it('should flow  1 function',  function () assert.same(3,    flow(h)(1, 2)) end)
      it('should flow  2 functions', function () assert.same(6,    flow(h, g)(1, 2)) end)
      it('should flow  3 functions', function () assert.same(7,    flow(h, g, e)(1, 2)) end)
      it('should flow  4 functions', function () assert.same(14,   flow(h, g, e, g)(1, 2)) end)
      it('should flow  5 functions', function () assert.same(15,   flow(h, g, e, g, e)(1, 2)) end)
      it('should flow  6 functions', function () assert.same(30,   flow(h, g, e, g, e, g)(1, 2)) end)
      it('should flow  7 functions', function () assert.same(31,   flow(h, g, e, g, e, g, e)(1, 2)) end)
      it('should flow  8 functions', function () assert.same(62,   flow(h, g, e, g, e, g, e, g)(1, 2)) end)
      it('should flow  9 functions', function () assert.same(63,   flow(h, g, e, g, e, g, e, g, e)(1, 2)) end)
      it('should flow 10 functions', function () assert.same(126,  flow(h, g, e, g, e, g, e, g, e, g)(1, 2)) end)
      it('should flow 11 functions', function () assert.same(127,  flow(h, g, e, g, e, g, e, g, e, g, e)(1, 2)) end)
      it('should flow 12 functions', function () assert.same(254,  flow(h, g, e, g, e, g, e, g, e, g, e, g)(1, 2)) end)
      it('should flow 13 functions', function () assert.same(255,  flow(h, g, e, g, e, g, e, g, e, g, e, g, e)(1, 2)) end)
      it('should flow 14 functions', function () assert.same(510,  flow(h, g, e, g, e, g, e, g, e, g, e, g, e, g)(1, 2)) end)
      it('should flow 15 functions', function () assert.same(511,  flow(h, g, e, g, e, g, e, g, e, g, e, g, e, g, e)(1, 2)) end)
      it('should flow 16 functions', function () assert.same(1022, flow(h, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g)(1, 2)) end)
      it('should flow 17 functions', function () assert.same(1023, flow(h, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e)(1, 2)) end)
      it('should flow 18 functions', function () assert.same(2046, flow(h, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g)(1, 2)) end)
      it('should flow 19 functions', function () assert.same(2047, flow(h, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e)(1, 2)) end)
      it('should flow 20 functions', function () assert.same(4094, flow(h, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g)(1, 2)) end)
      it('should flow 21 functions', function () assert.same(4095, flow(h, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e, g, e)(1, 2)) end)
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
