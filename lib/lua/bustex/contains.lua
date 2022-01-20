local a = require('luassert')
local s = require('say')

local function contains (container, contained)
   if container == contained then return true end

   local container_type = type(container)
   local contained_type = type(contained)

   if container_type ~= contained_type then return false end

   if container_type == 'table' then
      for k, v in pairs(contained) do
         if not contains(container[k], v) then return false end
      end

      return true
   end

   return false
end

local function contains_for_luassert (_, arguments)
   return contains(arguments[1], arguments[2])
end

s:set('assertion.contains.positive', 'Expected %s\n to contain\n%s')
s:set('assertion.contains.negative', 'Expected %s\n to not contain\n%s')

a:register(
   'assertion',
   'contains',
   contains_for_luassert,
   'assertion.contains.positive',
   'assertion.contains.negative'
)
