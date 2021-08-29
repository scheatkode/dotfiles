local f = require('f')

describe('functional', function ()
   describe('iterators', function ()
      describe('basic behaviour', function ()
         it('should run an iteration when called directly', function ()
            local t = {1, 2, 3, 4}
            local i = f.iterate(t)

            assert.same(1, i())
         end)

         it('should sepecify that it is an iterator', function ()
            local t = {1, 2, 3, 4}
            local i = f.iterate(t)

            assert.same('<iterator>', tostring(i))
         end)

         it('should be a (somewhat) drop-in replacement for ipairs', function ()
            local t = {1, 2, 3, 4}
            local r = {}

            for _, i in f.iterate(t) do
               r[#r + 1] = i
            end

            assert.same(#t, #r)
            assert.same(t, r)
         end)

         it('should be a (somewhat) drop-in replacement for pairs', function ()
            local t = { first = 1, second = 2, third = 3, fourth = 4 }
            local r = {}

            for _, k, v in f.iterate(t) do
               r[k] = v
            end

            assert.same(t, r)
         end)

         it('should iterate over all elements', function ()
            local t = { first = 1, second = 2, third = 3, fourth = 4 }
            local r = {}

            f.iterate(t):foreach(function (key, value)
               r[key] = value
            end)

            assert.same(t, r)
         end)
      end)

      describe('construction', function ()
         it('should not generate an iterator over a non iterable object', function ()
            assert.error(function () f.iterate(0) end)
         end)

         it('should generate an iterator over the given string', function ()
            local i = 1
            local t = { 's', 'o', 'm', 'e', 't', 'h', 'i', 'n', 'g' }

            for k, v in f.iterate('something') do
               assert.same(k, i)
               assert.same(v, t[i])

               i = i + 1
            end
         end)

         it('should generate an iterator over the given table', function ()
            local i = 1
            local t = { 1, 2, 3, 4, 5 }

            for _, v in f.iterate(t) do
               assert.same(t[i], i)
               assert.same(t[i], v)

               i = i + 1
            end
         end)

         it('should always return a valid iterator even when given an iterator', function ()
            local t = {1, 2, 3}
            local r = {}

            for _, v in
               f.iterate(f.iterate(f.iterate(t)))
            do
               table.insert(r, v)
            end

            assert.same(t, r)
         end)

         it('should still return a valid iterator even when given an iterator', function ()
            local t = {1, 2, 3}
            local r = {}

            for _, v in
               f.iterate(t):iterate(t):iterate(t)
            do
               table.insert(r, v)
            end

            assert.same(t, r)
         end)

         it('should return a valid iterator when recycling an iterator nevertheless', function ()
            local s = {1, 2, 3}
            local t = {4, 5, 6}
            local r = {}

            f.iterate(s):iterate(t):foreach(function (v)
               table.insert(r, v)
            end)

            assert.same(t, r)
         end)
      end)

      describe('ranging', function ()
         it('should generate a range of numbers', function ()
            local i = 1

            for _, k in f.range(20) do
               assert.same(i, k)
               i = i + 1
            end
         end)

         it('should generate a range of numbers starting from 1', function ()
            local i = 1

            f.range(20):foreach(function (x)
               assert.same(i, x)
               i = i + 1
            end)
         end)

         it('should generate a range of numbers with a specified start', function ()
            local i = 10

            f.range(10, 30):foreach(function (x)
               assert.same(i, x)
               i = i + 1
            end)
         end)

         it('should generate a range of numbers with a specified step', function ()
            local i = 1

            f.range(1, 100, 5):foreach(function (x)
               assert.same(i, x)
               i = i + 5
            end)
         end)

         it('should generate a range of numbers with a decimal step', function ()
            local i = 1

            f.range(1, 1.6, 0.1):foreach(function (x)
               assert.same(i, x)
               i = i + 0.1
            end)
         end)

         it('should generate a range of numbers with a negative step', function ()
            local i = 100

            f.range(1, 100, -5):foreach(function (x)
               assert.same(i, x)
               i = i - 5
            end)
         end)

         it('should be somewhat fast', function ()
            local i = 1

            f.range(20):foreach(function (x)
               assert.same(i, x)
               i = i + 1
            end)
         end)
      end)

      describe('infinite generations', function ()
         it('should generate indefinitely', function ()
            f.duplicate(47):take(20):foreach(function (x)
               assert.same(47, x)
            end)
         end)

         it('should still generate indefinitely', function ()
            f.duplicate(1, 2, 3, 4, 5):take(20):foreach(function (a, b, c, d, e)
               assert.same(1, a)
               assert.same(2, b)
               assert.same(3, c)
               assert.same(4, d)
               assert.same(5, e)
            end)
         end)

         it('should only generate zeros', function ()
            f.zeros():take(20):foreach(function (x)
               assert.same(0, x)
            end)
         end)

         it('should only generate ones', function ()
            f.ones():take(20):foreach(function (x)
               assert.same(1, x)
            end)
         end)

         it('should generate an iterator from the given function', function ()
            local round = 0

            f.tabulate(function (x) return 20 * x end):take(20):foreach(function (x)
               assert.same(round, x)
               round = round + 20
            end)
         end)
      end)

      describe('random sampling', function ()
         it('should generate pseudo-random real numbers in the [0,1] interval', function ()
            assert.truthy(f.random():take(20):every(function (x) return x >= 0 and x < 1 end))
            assert.unique(f.random():take(20))
         end)

         it('should raise an error if the interval is empty', function ()
            assert.error(function () f.random(0) end)
         end)

         it('should generate pseudo-random integers in the specified interval', function ()
            assert.truthy(f.random(1024):take(20):every(function (x)
               return math.floor(x) == x
            end))
         end)

         it('should still generate pseudo-random integers lesser than the given bound', function ()
            assert.truthy(f.random(2):take(20):every(function (x)
               return math.floor(x) == x
            end))
         end)

         it('should generate only zeros from the bounded interval', function ()
            assert.truthy(f.random(0, 1):take(20):every(function (x)
               return x == 0
            end))
         end)

         it('should still generate only the lower bound', function ()
            assert.truthy(f.random(1024, 1025):take(20):every(function (x)
               return x == 1024
            end))
         end)

         it('should generate pseudo-random integers in the specified bound', function ()
            assert.truthy(f.random(1024, 2048):take(20):every(function (x)
               return x >= 1024 and x < 2048
            end))
            assert.unique(f.random(1024, 2048):take(20))
         end)
      end)

      describe('slicing', function ()
         it('should return the value from the n-th iteration', function ()
            -- assert.same(3, f.nth(3, f.range(5)))
            assert.same(3, f.range(5):nth(3))
         end)

         it('should return nil when the iterator is fully consumed', function ()
            assert.same(nil, f.range(5):nth(6))
         end)

         it('should return the n-th element when given a table', function ()
            assert.same('c', f.nth(3, {'a', 'b', 'c', 'd'}))
         end)

         it('should return the n-th character when given a string', function ()
            assert.same('c', f.nth(3, 'abcd'))
         end)
      end)

      it('should be able to iterate through all elements of a table', function ()
         local t = { first = 1, second = 2, third = 3, fourth = 4 }
         local r = {}

         f.iterate(t):foreach(function (x, y) r[x] = y end)

         assert.same(t, r)
      end)

      it('should be able to iterate through all elements of a table', function ()
         local s = 'something'
         local r = {}

         f.iterate(s):foreach(function (x) table.insert(r, x) end)

         assert.same({'s', 'o', 'm', 'e', 't', 'h', 'i', 'n', 'g'}, r)
      end)

      it('should always return the nth element of the iterator', function ()
         local t = { 'first', 'second', 'third', 'fourth' }
         local r = f.iterate(t)

         assert.same('first',  r:nth(1))
         assert.same('first',  r:nth(1))
         assert.same('second', r:nth(2))
         assert.same('second', r:nth(2))
         assert.same('third',  r:nth(3))
         assert.same('third',  r:nth(3))
         assert.same('fourth', r:nth(4))
         assert.same('fourth', r:nth(4))
      end)

      it('should always return `nil` when the iterator is exceeded', function ()
         local t = { 1, 2, 3, 4 }
         local r = f.iterate(t)

         assert.same(nil, r:nth(5))
         assert.same(nil, r:nth(6))
         assert.same(nil, r:nth(7))
         assert.same(nil, r:nth(8))
         assert.same(nil, r:nth(9))
      end)

      it('should always return the first element of the iterator', function ()
         local t = { 'first', 'second', 'third', 'fourth' }
         local r = f.iterate(t)

         assert.same('first', r:head())
         assert.same('first', r:head())
      end)

      it('should raise an exception when the iterator is empty', function ()
         local r = f.iterate({})

         assert.error(function () r:head() end)
      end)

      it('should always the iterator without its first element', function ()
         local t = { 'first', 'second', 'third', 'fourth' }
         local r = f.iterate(t)

         assert.same('second', r:tail():head())
         assert.same('second', r:tail():head())
      end)
   end)
end)
