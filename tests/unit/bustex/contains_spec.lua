require('bustex.contains')

describe('busted extensions', function ()
   describe('contains', function ()
      it('should work for basic cases', function ()
         assert.contains({a = 1, b = 2, c = 3}, {a = 1})
         assert.contains({a = 1, b = 2, c = 3}, {a = 1, c = 3})

         assert.not_contains({a = 1, b = 2, c = 3}, {c = 5})
         assert.not_contains({a = 1, b = 2, c = 3}, {d = 5})
         assert.not_contains({a = 1, b = 2, c = 3}, {a = 1, b = 5, c = 3})
      end)

      it('should work for complex cases', function ()
         assert.contains({a = {b = 1}, c = 1}, {a = {b = 1}})
      end)
   end)
end)
