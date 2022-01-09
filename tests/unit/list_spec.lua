local List = require('collection.list')

describe('list', function ()
   describe('creation', function ()
      it('should be created from a table correctly', function ()
         local t = {1, 2, 3, 4}
         local l = List(t)

         local i = 1

         l:iterate():foreach(function (x)
            assert.same(t[i], x)
            i = i + 1
         end)

         assert.same(t[1], l[1])
         assert.same(t[2], l[2])
         assert.same(t[3], l[3])
         assert.same(t[4], l[4])

         assert.same(5, i)
      end)
   end)
end)
