local sandbox = require('lib.sandbox')

describe('sandboxing', function ()
   describe('when handling base cases', function ()
      it('should run harmless strings', function ()
         assert.same('hello', sandbox.run('return "hello"'))
      end)

      it('should have access to safe methods', function ()
         assert.same(10, sandbox.run('return tonumber("10")'))
         assert.same('FOOBAR', sandbox.run('return string.upper("foobar")'))
         assert.same(1, sandbox.run('local a = {3,2,1}; table.sort(a); return a[1]'))
         assert.same(10, sandbox.run('return math.max(1, 10)'))
      end)

      it('should not allow access to unsafe code', function ()
         assert.error(function () sandbox.run('return metatable({}, {})') end)
         assert.error(function () sandbox.run('return string.rep("foobar", 5)') end)
      end)

      it('should be able to return multiple values', function ()
         local r = { sandbox.run('return "foo", "bar"') }
         assert.same({ 'foo', 'bar' }, r)
      end)
   end)

   describe('when handling string.rep', function ()
      it('should not allow string:rep', function ()
         assert.error(function () sandbox.run('return ("hello"):rep(5)') end)
      end)

      it('should restore the initial string.rep', function ()
         sandbox.run('')
         assert.same('barbarbar', string.rep('bar', 3))
      end)

      it('should restore string.rep even if an error occurred', function ()
         assert.error(function () sandbox.run('error("foobar")') end)
         assert.same('barbarbar', string.rep('bar', 3))
      end)

      it('should pass parameters to the sandboxed code', function ()
         assert.same(3, sandbox.run('local a, b = ...; return a + b', {}, 1, 2))
      end)
   end)

   describe('when the sandboxed code attempts to modify the base environment', function ()
      it('should not be able to do so for modules', function ()
         assert.error(function () sandbox.run('string.foo  = 1') end)
         assert.error(function () sandbox.run('string.char = 2') end)
      end)

      it('should not persist modifications to base functions', function ()
         sandbox.run('error = function() end')
         assert.error(function () assert.run('error("this error should be raised")') end)
      end)

      it('should not persist modifications to base functions even when provided by the sandboxed environment', function ()
         local environment = { ['next'] = 'foobar' }

         sandbox.run('next = "foobaz"', { environment = environment })
         assert.same(environment['next'], 'foobar')
      end)
   end)

   describe('when given infinite loops', function ()
      it('should throw an error with infinite loops', function ()
         assert.error(function () sandbox.run('while true do end') end)
      end)

      it('should restore string.rep after an infinite loop', function ()
         assert.error(function () sandbox.run('while true do end') end)
         assert.same('barbarbar', string.rep('bar', 3))
      end)

      it('should accept a quota parameter', function ()
         assert.has_no.errors(function () sandbox.run('for i = 1, 100 do end') end)
         assert.error(function () sandbox.run('for i = 1, 100 do end', { quota = 20 }) end)
      end)

      it('should not use quotas if the quota parameter is false', function ()
         assert.has_no.errors(function ()
            sandbox.run('for i = 1, 1000000 do end', { quota = false })
         end)
      end)
   end)

   describe('when given an environment option', function ()
      it('should be available to the sandboxed environment as the _G variable', function ()
         local environment = { foo = 1 }

         assert.same(1, sandbox.run('return foo', { environment = environment }))
         assert.same(1, sandbox.run('return _G.foo', { environment = environment }))
      end)

      it('should not hide the base environment', function ()
         assert.same('FOOBAR', sandbox.run('return string.upper(foo)', {environment = {foo = 'foobar'}}))
      end)

      it('should not be able to modify the environment', function ()
         local environment = { foo = 1 }

         sandbox.run('foo = 2', {environment = environment})
         assert.same(1, environment.foo)
      end)

      it('should use the environment metatable, if it exists', function ()
         local env1 = { foo = 1 }
         local env2 = { bar = 2 }

         setmetatable(env2, { __index = env1 })
         assert.same(3, sandbox.run('return foo + bar', { environment = env2 }))
      end)

      it('should override the sandboxed environment', function ()
         local environment = { tostring = function (x) return 'hello ' .. x end }
         assert.same('hello alice', sandbox.run('return tostring("alice")', { environment = environment }))
      end)

      it('should override the base environment with false', function ()
         local environment = { tostring = false }
         assert.same(false, sandbox.run('return tostring', { environment = environment }))
      end)
   end)
end)
