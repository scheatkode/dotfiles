---@diagnostic disable: unused-local, unused-vararg

local m = {}

-- TODO(scheatkode): Documentation
local function create_index_wrapper(c, f)
   if f == nil then
      return c.__instance_dictionary
   end

   if type(f) == 'function' then
      return function(self, name)
         local value = c.__instance_dictionary[name]

         if value ~= nil then
            return value
         end

         return f(self, name)
      end
   end

   -- f should be a `table` here.
   return function (self, name)
      local value = c.__instance_dictionary[name]

      if value ~= nil then
         return value
      end

      return f[name]
   end
end

-- TODO(scheatkode): Documentation
local function propagate_instance_method(c, name, f)
   f = (
          name == '__index'
      and create_index_wrapper(c, f)
      or  f
   )

   c.__instance_dictionary[name] = f

   for subclass in pairs(c.subclasses) do
      if rawget(subclass.__declared_methods, name) == nil then
         propagate_instance_method(subclass, name, f)
      end
   end
end

-- TODO(scheatkode): Documentation
local function declare_instance_method(c, name, f)
   c.__declared_methods[name] = f

   if f == nil and c.super then
      f = c.super.__instance_dictionary[name]
   end

   propagate_instance_method(c, name, f)
end

-- TODO(scheatkode): Documentation
local function __tostring(self) return
   'class ' .. self.name
end

-- TODO(scheatkode): Documentation
local function __call(self, ...) return
   self:new(...)
end

-- TODO(scheatkode): Documentation
local function create_class(name, super)
   local dictionary = {}
   dictionary.__index = dictionary

   local c = {
                       name = name,
                      super = super,
                  prototype = {},
      __instance_dictionary = dictionary,
         __declared_methods = {},
                 subclasses = setmetatable({}, {__mode='k'})
   }

   if super then
      setmetatable(c.prototype, {
         __index = function(_, k)
            local result = rawget(dictionary, k)

            if result == nil then
               return super.prototype[k]
            end

            return result
         end
      })
   else
      setmetatable(c.prototype, {
         __index = function(_, k)
            return rawget(dictionary, k)
         end
      })
   end

   setmetatable(c, {
         __index = c.prototype,
      __tostring = __tostring,
          __call = __call,
      __newindex = declare_instance_method
   })

   return c
end

-- TODO(scheatkode): Documentation
local function include_mixin(c, mixin)
   assert(type(mixin) == 'table', 'mixin must be a table')

   for name, method in pairs(mixin) do
      if
             name ~= 'included'
         and name ~= 'prototype'
      then
         c[name] = method
      end
   end

   for name, method in pairs(mixin.prototype or {}) do
      c.prototype[name] = method
   end

   if type(mixin.included) == 'function' then
      mixin:included(c)
   end

   return c
end

-- TODO(scheatkode): Documentation
local default_mixin = {
       __tostring = function(self) return 'instance of ' .. tostring(self.class) end,
       construct  = function(self, ...) end,
   is_instance_of = function(self, c)
      return type(c)    == 'table'
         and type(self) == 'table'
         and (
                self.class == c
            or  type(self.class) == 'table'
            and type(self.class.is_subclass_of) == 'function'
            and self.class:is_subclass_of(c)
         )
   end,

   prototype = {
      allocate = function(self)
         assert(type(self) == 'table', [[Make sure that you are using 'Class:allocate' instead of 'Class.allocate']])
         return setmetatable({ class = self }, self.__instance_dictionary)
      end,

      new = function(self, ...)
         assert(type(self) == 'table', [[Make sure that you are using 'Class:new' instead of 'Class.new']])

         local instance = self:allocate()
         instance:construct(...)
         return instance
      end,

      subclass = function(self, name)
         assert(type(self) == 'table',  [[Make sure that you are using 'Class:subclass' instead of 'Class.subclass']])
         assert(type(name) == 'string', 'You must provide a name for your class')

         local subclass = create_class(name, self)

         for method, f in pairs(self.__instance_dictionary) do
            if not (
                   method  == '__index'
               and type(f) == 'table'
            ) then
               propagate_instance_method(subclass, method, f)
            end
         end

         subclass.construct = function(instance, ...)
            return self.construct(instance, ...)
         end

         self.subclasses[subclass] = true
         self:subclassed(subclass)

         return subclass
      end,

      subclassed = function(self, other) end,

      is_subclass_of = function(self, other)
         return type(other)      == 'table'
            and type(self.super) == 'table'
            and (
                  self.super == other
               or self.super:is_subclass_of(other)
            )
      end,

      include = function(self, ...)
         assert(type(self) == 'table', [[Make sure you that you are using 'Class:include' instead of 'Class.include']])

         for _, mixin in ipairs({...}) do
            include_mixin(self, mixin)
         end

         return self
      end
   }
}

-- TODO(scheatkode): Documentation
function m.class(name, super)
   assert(type(name) == 'string', 'A name is needed for the new class')

   return super
      and super:subclass(name)
      or  include_mixin(create_class(name), default_mixin)
end

setmetatable(m, {
   __call = function(_, ...)
      return m.class(...)
   end
})

return m
