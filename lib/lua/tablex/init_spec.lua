local tablex = require('tablex')

describe('tablex', function ()
   describe('is_empty', function ()
      it('should throw an error when given nil', function ()
         assert.error(function () tablex.is_empty(nil) end)
      end)

      it('should throw an error when given a number', function ()
         assert.error(function () tablex.is_empty(1) end)
      end)

      it('should throw an error when given a string', function ()
         assert.error(function () tablex.is_empty('abc') end)
      end)

      it('should throw an error when given a function', function ()
         assert.error(function () tablex.is_empty(function() end) end)
      end)

      it('should be truthy when given an empty table', function ()
         assert.same(true, tablex.is_empty({}))
      end)

      it('should be falsy when given a non-empty table', function ()
         assert.same(false, tablex.is_empty({1, 2, 3}))
      end)

      it('should be falsy when given a non-empty hash-like table', function ()
         assert.same(false, tablex.is_empty({a = 1, b = 2, c = 3}))
      end)
   end)

   describe('is_list', function ()
      it('should be falsy when given nil', function ()
         assert.same(false, tablex.is_list(nil))
      end)

      it('should be falsy when given a number', function ()
         assert.same(false, tablex.is_list(1))
      end)

      it('should be falsy when given a string', function ()
         assert.same(false, tablex.is_list('abc'))
      end)

      it('should be falsy when given a function', function ()
         assert.same(false, tablex.is_list(function() end))
      end)

      it('should be truthy when given an empty table', function ()
         assert.same(true, tablex.is_list({}))
      end)

      it('should be truthy when given a list of numbers', function ()
         assert.same(true, tablex.is_list({1, 2, 3}))
      end)

      it('should be truthy when given a list of strings', function ()
         assert.same(true, tablex.is_list({'a', 'b', 'c'}))
      end)

      it('should be truthy when given a list of numbers and strings', function ()
         assert.same(true, tablex.is_list({1, 2, 'abc', 'foo'}))
      end)

      it('should be falsy when given a hybrid table', function ()
         assert.same(false, tablex.is_list({1, 2, 'abc', a = 'foo'}))
      end)

      it('should be falsy when given a hybrid table', function ()
         assert.same(false, tablex.is_list({a = 'foo', 1, 2, 'abc'}))
      end)
   end)

   describe('deep_extend', function ()
      it('should throw an error when given an invalid behavior', function ()
         assert.error(tablex.deep_extend)
      end)

      it('should throw an error when no table is given', function ()
         assert.error(function () tablex.deep_extend('keep') end)
      end)

      it('should throw an error when only one table is given', function ()
         assert.error(function () tablex.deep_extend('keep', {}) end)
      end)

      describe('with keeping behavior', function ()
         it('should extend two tables without overwriting existing elements', function ()
            local a = {x = {a = 1, b = 2}}
            local b = {x = {a = 2, c = {y = 3}}}

            local actual   = tablex.deep_extend('keep', a, b)
            local expected = {x = {a = 1, b = 2, c = {y = 3}}}

            assert.same(expected, actual)
         end)

         it('should extend three tables without overwriting existing elements', function ()
            local a = {x = {a = 1, b = 2}}
            local b = {x = {a = 2, c = {y = 3}}}
            local c = {x = {c = 4, d = {y = 4}}}

            local actual   = tablex.deep_extend('keep', a, b, c)
            local expected = {x = {a = 1, b = 2, c = {y = 3}, d = {y = 4}}}

            assert.same(expected, actual)
         end)
      end)

      describe('with forcing behavior', function ()
         it('should extend two tables overwriting existing elements', function ()
            local a = {x = {a = 1, b = 2}}
            local b = {x = {a = 2, c = {y = 3}}}

            local actual   = tablex.deep_extend('force', a, b)
            local expected = {x = {a = 2, b = 2, c = {y = 3}}}

            assert.same(expected, actual)
         end)

         it('should extend three tables overwriting existing elements', function ()
            local a = {x = {a = 1, b = 2}}
            local b = {x = {a = 2, c = {y = 3}}}
            local c = {x = {c = 4, d = {y = 4}}}

            local actual   = tablex.deep_extend('force', a, b, c)
            local expected = {x = {a = 2, b = 2, c = 4, d = {y = 4}}}

            assert.same(expected, actual)
         end)
      end)
   end)
end)
