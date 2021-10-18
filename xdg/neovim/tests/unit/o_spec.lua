--- @diagnostic disable: duplicate-set-field, undefined-field

local class = require('lib.o')

describe('object oriented', function ()
   describe('constructor', function ()
      it('should throw an error when given no parameters', function ()
         assert.error(class)
      end)

      it('should have the correct name as well as Object as its superclass when given only a name', function ()
         local under_test = class('under_test')

         assert.equal(under_test.name, 'under_test')
         assert.is_nil(under_test.super)
      end)

      it('should have the correct name and superclass when given a name and a superclass', function ()
         local superclass_under_test = class('superclass')
         local   subclass_under_test = class('subclass', superclass_under_test)

         assert.equal(subclass_under_test.name, 'subclass')
         assert.equal(subclass_under_test.super, superclass_under_test)
      end)
   end)

   describe('class', function ()
      local c

      before_each(function ()
         c = class('some_class')
      end)

      it('should return the correct name', function ()
         assert.equal(c.name, 'some_class')
      end)

      it('should return the correct human-readable string', function ()
         assert.equal(tostring(c), 'class some_class')
      end)

      it('should create a new object when called directly', function ()
         local o = c()
         assert.equal(o.class, c)
      end)

      it('should throw an error when not called as a method', function ()
         assert.error(function () c.implement() end)
      end)

      it('should throw an error when given something other than a table', function ()
         assert.error(function () c:implement('foobar') end)
      end)

      describe('extend', function ()
         it('should throw an error when not called as a method', function ()
            assert.error(function () c.extend() end)
         end)

         it('should throw an error when no name is given', function ()
            assert.error(function () c:extend() end)
         end)

         local sub

         before_each(function ()
            function c.prototype:subclassed(other) self.prototype.child = other end
            sub = c:extend('some_subclass')
         end)

         it('should return the correct name of the subclass', function ()
            assert.equal(sub.name, 'some_subclass')
         end)

         it('should register the correct superclass', function ()
            assert.equal(sub.super, c)
         end)

         it('should invoke the subclassed hook method', function ()
            assert.equal(sub, c.child)
         end)

         it('should implement the subclass in the subclass table', function ()
            sub = c:extend('some_subclass')
            assert.is_true(c.subclasses[sub])
         end)
      end)

      describe('attributes', function ()
         local a, b

         before_each(function ()
            a = class('a')
            b = class('b')

            a.prototype.foo = 'bar'
         end)

         it('should be available after initialization', function ()
            assert.equal('bar', a.foo)
         end)

         it('should be overridable by subclasses without affecting the superclass', function ()
            b.prototype.foo = 'baz'

            assert.equal(b.foo, 'baz')
            assert.equal(a.foo, 'bar')
         end)
      end)

      describe('methods', function ()
         local a, b

         before_each(function ()
            a = class('a')
            b = class('b', a)

            function a.prototype:foo () return 'bar' end
         end)

         it('should be available after initialization', function ()
            assert.equal(a:foo(), 'bar')
         end)

         it('should be available to subclasses', function ()
            assert.equal(b:foo(), 'bar')
         end)

         it('should be overridable by subclasses without affecting the superclass', function ()
            function b.prototype:foo () return 'baz' end

            assert.equal(b:foo(), 'baz')
            assert.equal(a:foo(), 'bar')
         end)
      end)
   end)

   describe('default method', function ()
      local Object

      before_each(function ()
         Object = class('Object')
      end)

      it('should set the name correctly', function ()
         assert.equal('Object', Object.name)
      end)

      it('should return a human-readable string representation of the class', function ()
         assert.equal('class Object', tostring(Object))
      end)

      it('should return a new object when called directly', function ()
         local o = Object()

         assert.is_true(o:is_instance_of(Object))
      end)

      describe('extend', function ()
         it('should throw an error when not called as a method', function ()
            assert.error(function () Object.extend() end)
         end)

         it('should throw an error when no name is given', function ()
            assert.error(function () Object:extend() end)
         end)

         local sub

         before_each(function ()
            sub = Object:extend('subclass')
         end)

         it('should create a class with the correct name', function ()
            assert.equal('subclass', sub.name)
         end)

         it('should create a class with the correct superclass', function ()
            sub = Object:extend('subclass')
            assert.equal(Object, sub.super)
         end)

         it('should be registered in the superclass table', function ()
            sub = Object:extend('subclass')
            assert.is_true(Object.subclasses[sub])
         end)
      end)

      describe('instance creation', function ()
         local sub

         before_each(function ()
            sub = class('sub')
            function sub:construct() self.mark = true end
         end)

         it('should allocate instances properly', function ()
            local instance = sub:allocate()

            assert.equal(sub, instance.class)
            assert.equal('instance of ' .. tostring(sub), tostring(instance))
         end)

         it('should throw an error when not called as a method', function ()
            assert.error(sub.allocate)
         end)

         it('should not call the constructor', function ()
            local instance = sub:allocate()
            assert.is_nil(instance.mark)
         end)

         it('should be overridden', function ()
            local previous = sub.prototype.allocate

            function sub.prototype:allocate ()
               local instance = previous(sub)

               instance.mark = true

               return instance
            end

            local instance = sub:allocate()
            assert.is_true(instance.mark)
         end)

         it('should construct instances properly', function ()
            local instance = sub:new()
            assert.equal(sub, instance.class)
         end)

         it('should throw an error when not used as a method', function ()
            assert.error(sub.new)
         end)

         it('should call the constructor', function ()
            local instance = sub:new()
            assert.is_true(instance.mark)
         end)
      end)

      describe('instances of', function ()
         describe('primitives', function ()
            local o = Object:new()

            describe('when used as classes', function ()
               it ('object:is_instance_of(nil) should return false', function ()
                  assert.is_falsy(o:is_instance_of(nil))
               end)

               it ('object:is_instance_of(number) should return false', function ()
                  assert.is_falsy(o:is_instance_of(1))
               end)

               it ('object:is_instance_of(string) should return false', function ()
                  assert.is_falsy(o:is_instance_of('foobar'))
               end)

               it ('object:is_instance_of(table) should return false', function ()
                  assert.is_falsy(o:is_instance_of({}))
               end)

               it ('object:is_instance_of(function) should return false', function ()
                  assert.is_falsy(o:is_instance_of(function () end))
               end)

               it ('object:is_instance_of(Object) should return false', function ()
                  assert.is_falsy(o:is_instance_of(Object:new()))
               end)
            end)

            describe('when used as instances', function ()
               it ('Object.is_instance_of(nil, Object) should return false', function ()
                  assert.is_falsy(Object.is_instance_of(nil, Object))
               end)

               it ('Object.is_instance_of(number, Object) should return false', function ()
                  assert.is_falsy(Object.is_instance_of(1, Object))
               end)

               it ('Object.is_instance_of(string, Object) should return false', function ()
                  assert.is_falsy(Object.is_instance_of('foobar', Object))
               end)

               it ('Object.is_instance_of(table, Object) should return false', function ()
                  assert.is_falsy(Object.is_instance_of({}, Object))
               end)

               it ('Object.is_instance_of(function, Object) should return false', function ()
                  assert.is_falsy(Object.is_instance_of(function () end, Object))
               end)
            end)
         end)

         describe('an instance', function ()
            local c1 = class('c1')
            local c2 = class('c2', c1)
            local c3 = class('c3', c2)

            local unrelated = class('unrelated')

            local o1 = c1:new()
            local o2 = c2:new()
            local o3 = c3:new()

            it('should be true for its own class', function ()
               assert.is_true(o1:is_instance_of(c1))
               assert.is_true(o2:is_instance_of(c2))
               assert.is_true(o3:is_instance_of(c3))
            end)

            it('should be true for its superclass', function ()
               assert.is_true(o2:is_instance_of(c1))
               assert.is_true(o3:is_instance_of(c1))
               assert.is_true(o3:is_instance_of(c2))
            end)

            it('should be false for its subclasses', function ()
               assert.is_false(o1:is_instance_of(c2))
               assert.is_false(o1:is_instance_of(c3))
               assert.is_false(o2:is_instance_of(c3))
            end)

            it('should be false for unrelated classes', function ()
               assert.is_false(o1:is_instance_of(unrelated))
               assert.is_false(o2:is_instance_of(unrelated))
               assert.is_false(o3:is_instance_of(unrelated))
            end)
         end)
      end)

      describe('subclasses of', function ()
         it('should be false for instances', function ()
            assert.is_false(Object:is_subclass_of(Object:new()))
         end)

         describe('primitives', function ()
            it('should return false for nil', function ()
               assert.is_false(Object:is_subclass_of(nil))
            end)

            it('should return false for number', function ()
               assert.is_false(Object:is_subclass_of(1))
            end)

            it('should return false for string', function ()
               assert.is_false(Object:is_subclass_of('foobar'))
            end)

            it('should return false for table', function ()
               assert.is_false(Object:is_subclass_of({}))
            end)

            it('should return false for function', function ()
               assert.is_false(Object:is_subclass_of(function () end))
            end)
         end)

         describe('any class', function ()
            local c1 = class('c1')
            local c2 = class('c2', c1)
            local c3 = class('c3', c2)

            local unrelated = class('unrelated')

            it('should be true for its direct superclass', function ()
               assert.is_true(c2:is_subclass_of(c1))
               assert.is_true(c3:is_subclass_of(c2))
            end)

            it('should be true for its ancestors', function ()
               assert.is_true(c3:is_subclass_of(c1))
            end)

            it('should be false for unrelated classes', function ()
               assert.is_false(c1:is_subclass_of(unrelated))
               assert.is_false(c2:is_subclass_of(unrelated))
               assert.is_false(c3:is_subclass_of(unrelated))
            end)
         end)
      end)
   end)

   describe('instance', function ()
      describe('attributes', function ()
         local person

         before_each(function ()
            person = class('person')

            function person:construct (name)
               self.name = name
            end
         end)

         it('should be available to the instance after initialization', function ()
            local alice = person:new('alice')

            assert.equal('alice', alice.name)
         end)

         it('should be available to the instance after being initialized by a superclass', function ()
            local aged = class('aged', person)

            function aged:construct (name, age)
               person.construct(self, name)
               self.age = age
            end

            local alice = aged:new('alice', 33)

            assert.equal('alice', alice.name)
            assert.equal(33, alice.age)
         end)
      end)

      describe('methods', function ()
         local A, B, a, b

         before_each(function ()
            A = class('A')

            function A:overridden() return 'foo' end
            function A:regular() return 'regular' end

            B = class('B', A)

            function B:overridden() return 'bar' end

            a = A:new()
            b = B:new()
         end)

         it('should be available to any instance', function ()
            assert.equal('foo', a:overridden())
         end)

         it('should be inheritable', function ()
            assert.equal('regular', b:regular())
         end)

         it('should be overridable', function ()
            assert.equal('bar', b:overridden())
         end)
      end)
   end)

   describe('mixin', function ()
      local m1, m2, c1, c2

      before_each(function ()
         m1, m2 = {}, {}

         function m1:implemented (c) c.includes_m1 = true end
         function m1:foo () return 'foo' end
         function m1:bar () return 'bar' end

         m1.prototype = {}
         m1.prototype.bazzz = function () return 'bazzz' end

         function m2:baz () return 'baz' end

         c1 = class('c1'):implement(m1, m2)
         function c1:foo () return 'foo1' end

         c2 = class('c2', c1)
         function c2:bar () return 'bar2' end
      end)

      it('should invoke the "implemented" method when implemented', function ()
         assert.is_true(c1.includes_m1)
      end)

      it('should have all methods except "implemented" copied to the target class', function ()
         assert.equal('bar', c1:bar())
         assert.is_nil(c1.implemented)
      end)

      it('should make its functions available to subclasses', function ()
         assert.equal('baz', c2:baz())
      end)

      it('should allow overriding of methods in the same class', function ()
         assert.equal('foo1', c2:foo())
      end)

      it('should allow overriding of methods in subclasses', function ()
         assert.equal('bar2', c2:bar())
      end)

      it('should make new prototype methods available in classes', function ()
         assert.equal('bazzz', c1:bazzz())
         assert.equal('bazzz', c2:bazzz())
      end)
   end)

   describe('default metamethod', function ()
      local Alice, alice

      before_each(function ()
         Alice = class('Alice')
         alice = Alice()
      end)

      it('should be accessible from classes', function ()
         assert.is_true(alice:is_instance_of(Alice))
      end)

      it('tostring should be assessible from classes', function ()
         assert.equal('class Alice', tostring(Alice))
      end)

      it('tostring should be accessible from instances', function ()
         assert.equal('instance of class Alice', tostring(alice))
      end)
   end)

   describe('custom metamethod', function ()
      local Vector, u, v

      before_each(function ()
         Vector = class('Vector')

         function Vector.construct(a, x, y, z) a.x, a.y, a.z = x, y, z end

         function Vector.__tostring(a)
            return a.class.name .. '[' .. a.x .. ',' .. a.y .. ',' .. a.z .. ']'
         end

         function Vector.__eq(a, b)
            return a.x == b.x
               and a.y == b.y
               and a.z == b.z
         end

         function Vector.__lt(a, b) return a() <  b() end
         function Vector.__le(a, b) return a() <= b() end

         function Vector.__add(a, b)
            return a.class:new(a.x + b.x, a.y + b.y ,a.z + b.z)
         end

         function Vector.__sub(a, b)
            return a.class:new(a.x - b.x, a.y - b.y, a.z - b.z)
         end

         function Vector.__div(a, s)
            return a.class:new(a.x / s, a.y / s, a.z / s)
         end

         function Vector.__unm(a)
            return a.class:new(-a.x, -a.y, -a.z)
         end

         function Vector.__concat(a, b)
            return a.x * b.x + a.y * b.y + a.z * b.z
         end

         function Vector.__call(a)
            return math.sqrt(a.x * a.x + a.y * a.y + a.z * a.z)
         end

         function Vector.__pow(a, b)
            return a.class:new(
               a.y * b.z - a.z * b.y,
               a.z * b.x - a.x * b.z,
               a.x * b.y - a.y * b.x
            )
         end

         function Vector.__mul(a, b)
            if type(b)=="number" then return a.class:new(a.x * b, a.y * b, a.z * b) end
            if type(a)=="number" then return b.class:new(a * b.x, a * b.y, a * b.z) end
         end

         Vector.__metatable = "metatable of a vector"
         Vector.__mode      = "k"

         u = Vector:new(1, 2, 3)
         v = Vector:new(2, 4, 6)
      end)

      it('should implement __tostring', function ()
         assert.equal('Vector[1,2,3]', tostring(u))
      end)

      it('should implement __eq', function ()
         assert.equal(u, u)
      end)

      it('should implement __lt', function ()
         assert.is_true(u < v)
      end)

      it('should implement __le', function ()
         assert.is_true(u <= v)
      end)

      it('should implement __add', function ()
         assert.equal(Vector(3,6,9), u + v)
      end)

      it('should implement __sub', function ()
         assert.equal(Vector(1,2,3), v - u)
      end)

      it('should implement __div', function ()
         assert.equal(Vector(1,2,3), v / 2)
      end)

      it('should implement __unm', function ()
         assert.equal(Vector(-1, -2, -3), -u)
      end)

      it('should implement __concat', function ()
         assert.equal(28, u .. v)
      end)

      it('should implement __call', function ()
         assert.equal(math.sqrt(14), u())
      end)

      it('should implement __pow', function ()
         assert.equal(Vector(0,0,0), u ^ v)
      end)

      it('should implement __mul', function ()
         assert.equal(Vector(4,8,12), 4 * u)
      end)

      it('should implement __metatable', function ()
         assert.equal('metatable of a vector', getmetatable(u))
      end)

      it('should implement __mode', function ()
         u[{}] = true
         collectgarbage()
         for k in pairs(u) do assert.not_table(k) end
      end)

      describe('inheritance', function ()
         local Vector2, u2, v2

         before_each(function ()
            Vector2 = class('Vector2', Vector)

            function Vector2:construct (x, y, z)
               Vector.construct(self, x, y, z)
            end

            u2 = Vector2:new(1,2,3)
            v2 = Vector2:new(2,4,6)
         end)

         it('should work with __tostring', function ()
            assert.equal('Vector2[1,2,3]', tostring(u2))
         end)

         it('should work with __eq', function ()
            assert.equal(u2, u2)
         end)

         it('should work with __lt', function ()
            assert.is_true(u2 < v2)
         end)

         it('should work with __le', function ()
            assert.is_true(u2 <= v2)
         end)

         it('should work with __add', function ()
            assert.equal(Vector2(3,6,9), u2 + v2)
         end)

         it('should work with __sub', function ()
            assert.equal(Vector2(1,2,3), v2 - u2)
         end)

         it('should work with __div', function ()
            assert.equal(Vector2(1,2,3), v2 / 2)
         end)

         it('should work with __unm', function ()
            assert.equal(Vector2(-1, -2, -3), -u2)
         end)

         it('should work with __concat', function ()
            assert.equal(28, u2 .. v2)
         end)

         it('should work with __call', function ()
            assert.equal(math.sqrt(14), u2())
         end)

         it('should work with __pow', function ()
            assert.equal(Vector2(0,0,0), u2 ^ v2)
         end)

         it('should work with __mul', function ()
            assert.equal(Vector2(4,8,12), 4 * u2)
         end)

         it('should work with __metatable', function ()
            assert.equal('metatable of a vector', getmetatable(u2))
         end)

         it('should work with __mode', function ()
            u2[{}] = true
            collectgarbage()
            for k in pairs(u2) do assert.not_table(k) end
         end)

         it('should allow further inheritance', function ()
            local Vector3 = class('Vector3', Vector2)
            local u3 = Vector3(1,2,3)
            local v3 = Vector3(3,4,5)

            assert.equal(Vector3(4,6,8), u3 + v3)
         end)

         describe('updates', function ()
            it('should override __add', function ()
               Vector2.__add = function (a, b) return Vector.__add(a, b) / 2 end
               assert.equal(Vector2(1.5, 3, 4.5), u2 + v2)
            end)

            it('should update __add', function ()
               Vector.__add = Vector.__sub
               assert.equal(Vector2(-1, -2, -3), u2 + v2)
            end)

            it('should not update __add after overriding', function ()
               Vector2.__add = function (a, b) return Vector.__add(a, b) / 2 end
               Vector.__add  = Vector.__sub

               assert.equal(Vector2(-0.5, -1, -1.5), u2 + v2)
            end)

            it('should revert __add overrides', function ()
               Vector2.__add = function (a, b) return Vector.__add(a, b) / 2 end
               Vector2.__add = nil

               assert.equal(Vector2(3, 6, 9), u2 + v2)
            end)
         end)
      end)

      describe('__index and __newindex', function ()
         local Proxy, fallback, p

         before_each(function ()
            Proxy = class('Proxy')

            fallback = { foo = 'bar', common = 'fallback' }

            Proxy.__index    = fallback
            Proxy.__newindex = fallback
            Proxy.common     = 'class'

            p = Proxy()
         end)

         it('should be used', function ()
            assert.equal('bar', p.foo)
         end)

         it('should not be used when the requested field exists in the class', function ()
            assert.equal('class', p.common)
         end)

         it('should be used', function ()
            p.key = 'value'
            assert.equal(fallback.key, 'value')
         end)

         it('should not be used when the requested field exists in the class', function ()
            p.common = 'value'

            assert.equal('class', p.common)
            assert.equal('class', Proxy.common)
            assert.equal('value', fallback.common)
         end)
      end)

      describe('functions', function ()
         local Namespace, Rectangle, r

         before_each(function ()
            Namespace = class('Namespace')

            function Namespace:__index(name)
               local getter = self.class[name .. 'Getter']

               if getter then
                  return getter(self)
               end
            end

            function Namespace:__newindex (name, value)
               local setter = self.class[name .. 'Setter']

               if setter then
                  setter(self, value)
               else
                  rawset(self, name, value)
               end
            end

            Rectangle = class('Rectangle', Namespace)

            function Rectangle:construct (x, y, scale)
               self._scale, self.x, self.y = 1, x, y
               self.scale = scale
            end

            function Rectangle:scaleGetter () return self._scale end
            function Rectangle:scaleSetter (w)
               self.x = self.x * w / self._scale
               self.y = self.y * w / self._scale
               self._scale = w
            end

            function Rectangle:areaGetter () return self.x * self.y end

            r = Rectangle(3, 4, 2)
         end)

         it('should use setters', function ()
            assert.equal(6, r.x)
            assert.equal(8, r.y)

            r.scale = 3

            assert.equal(9,  r.x)
            assert.equal(12, r.y)
         end)

         it('should use getters', function ()
            assert.equal(2, r.scale)
            assert.equal(48, r.area)
         end)

         it('should inherit updates from superclass', function ()
            function Namespace.__index () return 42 end
            assert.equal(42, r.area)

            function Rectangle.__index () return 24 end
            assert.equal(24, r.area)

            function Namespace.__index () return 96 end
            assert.equal(24, r.area)

            Rectangle.__index = nil

            assert.equal(96, r.area)
         end)
      end)
   end)
end)
