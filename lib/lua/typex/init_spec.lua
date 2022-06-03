local f = require('f')

local typex, istypex = require 'typex' ()

describe('typex', function ()
   describe('when called with a primitive type', function ()
      f
         .iterate({
            true, false,
            42,   0,     4.20,
            '',   'foobar',
            function () end
         })
         :foreach(function (x)
            it('should return "' .. type(x) .. '" when given a ' .. type(x), function ()
               assert.same(type(x), typex(x))
            end)
         end)

      it('should return "nil" when given nil', function ()
         assert.same('nil', typex(nil))
      end)

      it('should return "thread" when given a coroutine', function ()
         local v = coroutine.create(function () end)
         assert.same('thread', typex(v))
      end)
   end)

   describe('when given a file type', function ()
      it('should return the same type as io.type()', function ()
         local v = io.open('/dev/null') -- TODO(scheatkode): Check windows too

         assert.same(io.type(v), typex(v))
         v:close()
         assert.same(io.type(v), typex(v))
      end)
   end)

   describe('when given a table', function ()
      it('should return the value of the __type metafield if available', function ()
         assert.same('foobar', typex(setmetatable({}, { __type = 'foobar' })))
      end)

      it('should return the result of the __type metafield function if available', function ()
         assert.same('foobar', typex(setmetatable({}, { __type = function () return 'foobar' end})))
      end)

      it('should return "table" if __type is a field', function ()
         assert.same('table', typex({ __type = 'foobar' }))
      end)

      it('should return "table" if no __type metafield is found', function ()
         assert.same('table', typex({}))
      end)
   end)

   describe('(is_typex)', function ()
      describe('when called with a primitive type', function ()
         f
            .iterate({
               true, false,
               42,   0,     4.20,
               '',   'foobar',
               function () end
            })
            :foreach(function (x)
               it('should return true for variable of type ' .. typex(x), function ()
                  assert.is_true(istypex(type(x), x))
               end)
            end)

         it('should return "nil" when given nil', function ()
            assert.is_true(istypex('nil', nil))
         end)

         it('should return "thread" when given a coroutine', function ()
            local v = coroutine.create(function () end)
            assert.is_true(istypex('thread', v))
         end)
      end)

      describe('when given a file type', function ()
         it('should return the same type as io.type()', function ()
            local v = io.open('/dev/null') -- TODO(scheatkode): Check windows too

            assert.is_true(istypex(io.type(v), v))
            v:close()
            assert.is_true(istypex(io.type(v), v))
         end)
      end)

      describe('when given a table', function ()
         it('should return the value of the __type metafield if available', function ()
            assert.is_true(istypex('foobar', setmetatable({}, { __istype = 'foobar' })))
         end)

         it('should return the result of the __type metafield function if available', function ()
            local fun = function (_, x) return x == 'foobar' end

            assert.is_true(istypex('foobar', setmetatable({}, { __istype = fun })))
            assert.is_false(istypex('foobaz', setmetatable({}, { __istype = fun })))
         end)

         it('should return "table" if __type is a field', function ()
            assert.is_true(istypex('table', { __istype = 'foobar' }))
         end)

         it('should return "table" if no __type metafield is found', function ()
            assert.is_true(istypex('table', {}))
         end)
      end)

      describe('when given an invalid type checker', function ()
         it('should raise an error', function ()
            assert.error(function ()
               istypex('foobar', setmetatable({}, { __istype = true }))
            end)
         end)
      end)
   end)
end)
