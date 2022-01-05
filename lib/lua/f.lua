--- A   functional   library  inspired   heavily   from
--- `luafun`.
---
--- It revolves  around the concept of  iterators which
--- is the most basic  primitive after a function. Most
--- exposed functions take an iterator and return a new
--- one.
---
--- The simplest form of  iteration in Lua is `pairs()`
--- and `ipairs()`  which, when called outside  a loop,
--- generate :
---
--- <pre>
--- > = ipairs({'a', 'b', 'c'})
--- function: builtin#6     table: 0x42001520       0
--- </pre>
---
--- The returned values are referred to as an *iterator
--- triplet*, described below:
---
--- - `generator` — first value
--- > A  generating function  that can  produce a  next
--- > value on  each iteration.  It takes  advantage of
--- > multireturn  to  return  a new  `state`  and  and
--- > iteration value.
---
--- - `parameter` — second value
--- > A constant paramater intended to be consumed by a
--- > generating  function  and  is used  to  create  a
--- > specific instance of the generating function. For
--- > example, a table in the `ipairs` case.
---
--- - `state` — third value
--- > A transient state of an iterator that is modified
--- > after  each  iteration.  For instance,  an  array
--- > index in the `ipairs` case.
---
--- When calling the  `generator` function manually, we
--- get the following result :
---
--- <pre>
--  > generator, parameter, state =ipairs({'a', 'b', 'c'})
--  > = generator(parameter, state)
--  1       a
--- </pre>
---
--- The `generator`  function returned a new  state `1`
--- and the  next iteration value `a`.  Another call to
--- `generator`  would   return  the  next   state  and
--- iteration value.  When the  iterator is  consumed —
--- meaning there are no  more iterations left, a `nil`
--- is returned instead of the next state.
---
--- Let's   understand  iterations   with  a   concrete
--- example:
---
--- <pre>
--  for _, x in ipairs({'a', 'b', 'c'}) do print(x) end
--- </pre>
---
--- According  to the  Lua reference  manual, the  code
--- above is equivalent to :
---
--- <pre>
--- do
---     -- Initialize the iterator
---     local g, p, s = ipairs({'a', 'b', 'c'})
---     while true do
---         -- Next iteration
---         local s, v1, ···, vn = g(p, s)
---         if state == nil then break end
---         -- Assign values to our variables
---         _ = state
---         x = v1
---         -- Execute the code block
---         print(x)
---     end
--- end
--- </pre>
---
--- What this is means is :
---
--- - An iterator can be used together with `for .. in`
---   to generate a loop.
--- - An   iterator   is   fully  defined   using   the
---   `generator`,  `parameter`  and  `state`  iterator
---   triplet.
--- - The `nil` state marks the end of an iteration.
--- - An  iterator can  return an  arbitrary number  of
---   values (multireturn).
--- - It is possible to make some wrapping functions to
---   take  an  iterator  and  return  a  new  modified
---   iterator.
---
--- Iterators  can be  either pure  functional or  have
--- some  side effects  which returns  different values
--- for some  initial conditions. An iterator  *is pure
--- functional* if it meets the following criteria:
---
--- - `generator`  function  always  returns  the  same
---   values  for  the  same  `parameter`  and  `state`
---   values (idempotence property).
--- - `parameter` and  `state` values are  not modified
---   during  a  `generator`  call and  a  new  `state`
---   object    is   returned    instead   (referential
---   transparency property).
---
--- Pure  functional iterators  important in  that they
--- can be safety cloned  or reapplied without creating
--- side effects.
---
--- Iterators can  be *finite*  (end up  eventually) or
--- *infinite* (never  end). Since  there is no  way to
--- determine automatically if an iterator is finite or
--- not,  the library  function  can not  automatically
--- resolve infinite  loops. It  is your  obligation to
--- not pass infinite iterator to reducing functions.
---
--- Tracing  just-in-time  compilation is  a  technique
--- used by virtual machines  to optimize the execution
--- of a program at runtime.  This is done by recording
--- a   linear   sequence    of   frequently   executed
--- operations, compiling  them to native  machine code
--- and executing them.
---
--- First  off,  profiling  information  for  loops  is
--- collected. After a hot  loop has been identified, a
--- special tracing  mode is entered which  records all
--- executed operations for that loop. This sequence of
--- operations is  called a *trace*. The  trace is then
--- optimized  and compiled  to  machine code  (trace).
--- When this loop is executed again the compiled trace
--- is called instead of the program counterpart.
---
--- The LuaJIT  tracing compiler can detect  tail-, up-
--- and   down-recursion,    unroll   compositions   of
--- functions and  inline high-order functions.  All of
--- these concepts  make the foundation  for functional
--- programming.
local module = {}

--- # Initialization {{{1

local compat = require('compat')

local assert       = assert
local getmetatable = getmetatable
local setmetatable = setmetatable
local ipairs       = ipairs
local pairs        = pairs
local select       = select
local type         = type
local unpack       = compat.table_unpack

local mceil   = math.ceil
local mfloor  = math.floor
local mmax    = math.max
local mmin    = math.min
local mrandom = math.random

local sfind   = string.find
local sformat = string.format
local ssub    = string.sub

--- # Early declarations {{{1

local return_if_not_empty
local call_if_not_empty
local nil_generator
local string_generator
local hashmap_generator
local filterm_generator

--- # Iterator class {{{1
---
--- The  `Iterator`  is  the basic  primitive  of  this
--- library.

--- @class Iterator
--- @field generator function
--- @field parameter any
--- @field state     any
local Iterator = {}

Iterator.__index = Iterator

--- Makes  a `for`  loop  work. If  not called  without
--- `parameter` or `state`, will just generate with the
--- starting  `state`.  This   is  useful  because  the
--- original `luafun` will  also return `parameter` and
--- `state` in addition to  the iterator as a multival.
--- This   can  cause   problems  because   when  using
--- iterators as expressions,  the multivals can bleed.
--- For example `i.iter { 1, 2, i.iter { 3, 4 } }` will
--- not  work  because  the inner  iterator  returns  a
--- multival,  thus polluting  the  list with  internal
--- values. So instead we do not return `parameter` and
--- `state` as multivals when doing `wrap`. This causes
--- the first  loop iteration  to call  `parameter` and
--- `state` with `nil` because we didn't return them as
--- multivals. We have  to use `or` to  check for `nil`
--- and  default   to  interal  starting   `state`  and
--- `parameter`.
---
--- @param parameter any
--- @param state any
--- @return any
function Iterator:__call(parameter, state)
   return self.generator(
      parameter or self.parameter,
      state     or self.state
   )
end

--- Returns a  tag signifying  this is a  special class
--- used for iterating over lists.
---
--- @return string
function Iterator:__tostring()
   return '<iterator>'
end

--- # Helper functions {{{1

--- A function that returns  the given parameters as-is
--- when the current state is not nil.
---
--- @param stateX any
--- @vararg ... any
--- @return nil
--- @return ...
return_if_not_empty = function (stateX, ...)
   if stateX == nil then
      return stateX
   end

   return ...
end

--- Call  the  given  function  with the  rest  of  the
--- arguments as parameters.
---
--- @param f function
--- @param stateX any
--- @vararg ...
--- @return nil
--- @return any
call_if_not_empty = function(f, stateX, ...)
   if stateX == nil then
      return stateX
   end

   return stateX, f(...)
end

--- Returns a deep copy  of the given object. Non-table
--- objects are copied as  in a typical Lua assignment,
--- whereas  table  objects   are  copied  recursively.
--- Functions are  naively copied, so functions  in the
--- copied table  point to the same  functions as those
--- in the  input table.  Userdata and threads  are not
--- copied and will throw an error.
---
--- @param original any
--- @return any
local function deepcopy(original)
   local copy

   if type(original) == 'table' then
      copy = {}

      for k, v in next, original, nil do
         copy[deepcopy(k)] = deepcopy(v)
      end
   elseif type(original) == 'userdata'
      or  type(original) == 'thread'
   then
      error('deepcopy: wrong parameter type')
   else
      copy = original
   end

   return copy
end

--- A  special  hack for  zip/chain  to  skip last  two
--- states, if a wrapped iterator has been passed.
---
--- @vararg ...
--- @return number
local count_arguments = function (...)
   local n = select('#', ...)

   if n >= 3 then
      -- Fix last argument
      local it = select(n - 2, ...)

      if     type(it) == 'table'
         and getmetatable(it) == Iterator
         and it.parameter     == select(n - 1, ...)
         and it.state         == select(n, ...)
      then
         return n - 2
      end
   end

   return n
end

--- # Constructors {{{1
---
--- The section contains  functions to create iterators
--- from Lua objects.

--- @param  object    any
--- @param  parameter any
--- @param  state     any
--- @return any, any, any
local raw_iterator = function (object, parameter, state)
   assert(object ~= nil, 'invalid iterator')

   if type(object) == 'table' then
      local metatable = getmetatable(object)

      if     metatable ~= nil
         and metatable == Iterator
      then
         return object.generator, object.parameter, object.state
      end

      if #object > 0 then -- array
         return ipairs(object)
      else -- hash
         return hashmap_generator, object, nil
      end
   elseif type(object) == 'function' then
      return object, parameter, state
   elseif type(object) == 'string' then
      if #object == 0 then
         return nil_generator, nil, nil
      end

      return string_generator, object, 0
   end

   error(sformat(
      'object %s of type "%s" is not iterable',
      object, type(object)
   ))
end

--- Wraps the  iterator triplet  into a table  to allow
--- metamethods   and   calling   with   method   form.
--- Important! We  do not return `parameter`  and state
--- as multivals  like the  original `luafun`.  See the
--- `__call` metamethod for more information.
---
--- @see Iterator::__call
---
--- @param  generator any
--- @param  parameter any
--- @param  state     any
--- @return Iterator
local wrap = function (generator, parameter, state)
   return setmetatable({
      generator = generator,
      parameter = parameter,
          state = state,
   }, Iterator)
end

--- Unwrap  an  iterator  metatable into  the  iterator
--- triplet.
---
--- @param  self Iterator
--- @return any
--- @return any
--- @return any
local unwrap = function (self)
   return self.generator, self.parameter, self.state
end

--- Make  `generator`,  `parameter`,  `state`  iterator
--- from  the  given  iterable   object.  This  can  be
--- considered  as a  generalized version  of `pairs()`
--- and `ipairs()`.
---
--- The function distinguishes  between arrays and maps
--- using  `#object ==  0`  check to  detect maps.  For
--- arrays ipairs is used.  For maps a modified version
--- of pairs  is used that also  returns keys. Userdata
--- objects are handled in the same way as tables.
---
--- This is suitable for use in a `for .. in` loop.
---
--- <pre>
--- > for _, a in iterate({1, 2, 3}) do print(a) end
--- 1
--- 2
--- 3
---
--- > for _, k, v in iterate({a = 1, b = 2, c = 3}) do print(k, v) end
--- b 2
--- a 1
--- c 3
--- </pre>
---
--- The first cycle variable `_` is needed to store the
--- internal state  of the iterator. The  value must be
--- always ignored in loops:
---
--- <pre>
--- for _, a, b in iterate({a = 1, b = 2, c = 3}) do print(a, b) end
--- -- _ is some internal iterator state - always ignore it.
--- -- a, b are the values returned from the iterator.
--- </pre>
---
--- Simple  iterators like  `iterate({1,  2, 3})`  have
--- simple states, whereas other iterators like `zip()`
--- or `chain()` have complicated internal states whose
--- values may be senseless for the end user.
---
--- There  is also  the  possibility  to supply  custom
--- iterators to the function:
---
--- <pre>
--- > local function mypairs_gen(max, state)
---     if (state >= max) then
---             return nil
---     end
---     return state + 1, state + 1
--- end
---
--- > local function mypairs(max)
---     return mypairs_gen, max, 0
--- end
---
--- > for _, a in iter(mypairs(3)) do print(a) end
--- 1
--- 2
--- 3
--- </pre>
---
--- Iterators can return multiple values.
---
--- @param  object    any
--- @param  parameter any (optional)
--- @param  state     any (optional)
--- @return Iterator
local iterate = function (object, parameter, state)
   return wrap(raw_iterator(object, parameter, state))
end

--- Make  `generator`,  `parameter`,  `state`  iterator
--- from  the  given  iterable   object.  This  can  be
--- considered  as a  generalized version  of `pairs()`
--- and `ipairs()`.
---
--- The function distinguishes  between arrays and maps
--- using  `#object ==  0`  check to  detect maps.  For
--- arrays ipairs is used.  For maps a modified version
--- of pairs  is used that also  returns keys. Userdata
--- objects are handled in the same way as tables.
---
--- This is suitable for use in a `for .. in` loop.
---
--- <pre>
--- > for _, a in iterate({1, 2, 3}) do print(a) end
--- 1
--- 2
--- 3
---
--- > for _, k, v in iterate({a = 1, b = 2, c = 3}) do print(k, v) end
--- b 2
--- a 1
--- c 3
--- </pre>
---
--- The first cycle variable `_` is needed to store the
--- internal state  of the iterator. The  value must be
--- always ignored in loops:
---
--- <pre>
--- for _, a, b in iterate({a = 1, b = 2, c = 3}) do print(a, b) end
--- -- _ is some internal iterator state - always ignore it.
--- -- a, b are the values returned from the iterator.
--- </pre>
---
--- Simple  iterators like  `iterate({1,  2, 3})`  have
--- simple states, whereas other iterators like `zip()`
--- or `chain()` have complicated internal states whose
--- values may be senseless for the end user.
---
--- There  is also  the  possibility  to supply  custom
--- iterators to the function:
---
--- <pre>
--- > local function mypairs_gen(max, state)
---     if (state >= max) then
---             return nil
---     end
---     return state + 1, state + 1
--- end
---
--- > local function mypairs(max)
---     return mypairs_gen, max, 0
--- end
---
--- > for _, a in iter(mypairs(3)) do print(a) end
--- 1
--- 2
--- 3
--- </pre>
---
--- Iterators can return multiple values.
---
--- @param  object    any
--- @return Iterator
function Iterator:iterate(object)
   return iterate(object, self.parameter, self.state)
end

--- Execute `f` for each  iteration value. The function
--- is equivalent to the code below:
---
--- <pre>
--- for _, ... in iterate(generator, parameter, state) do
---    f(...)
--- end
--- </pre>
---
--- The  function   is  used  for  its   side  effects.
--- Implementation   directly   applies  `f`   to   all
--- iteration values without  returning a new iterator,
--- in contrast to functions like `map()`.
---
--- @param f function
--- @param generator function
--- @param parameter any
--- @param state any
--- @return nil
local function foreach (f, generator, parameter, state)
   repeat
      state = call_if_not_empty(f, generator(parameter, state))
   until state == nil
end

--- Execute `f` for each  iteration value. The function
--- is equivalent to the code below:
---
--- <pre>
--- for _, ... in iterate(generator, parameter, state) do
---    f(...)
--- end
--- </pre>
---
--- The  function   is  used  for  its   side  effects.
--- Implementation   directly   applies  `f`   to   all
--- iteration values without  returning a new iterator,
--- in contrast to functions like `map()`.
---
--- @param f function
--- @return nil
function Iterator:foreach (f)
   return foreach(f, self.generator, self.parameter, self.state)
end

--- Transforms the  given iterator into a  stateful one
--- to be  called repeatedly when  not being used  in a
--- loop.
---
--- <pre>
--- local iterator = with_state(iterate({'a', 'b', 'c'}))
--- iterator() -- 1   'a'
--- iterator() -- 2   'b'
--- iterator() -- 3   'c'
--- </pre>
---
--- The function is used  for its side effects, keeping
--- tabs on  the state  internally. This  version keeps
--- returning the state so it can be chained with other
--- functions from this library.
---
--- <pre>
--- foreach(print, with_state(generator, parameter, state))
--- </pre>
---
--- @param generator function
--- @param parameter any
--- @param state any
--- @return Iterator
local with_state = function (generator, parameter, state)
   local function return_and_retain_state(state_x, ...)
      state = state_x

      if state == nil then
         return nil
      end

      return state_x, ...
   end

   local function state_generator ()
      return return_and_retain_state(generator(parameter, state))
   end

   return wrap(state_generator)
end

--- Transforms the  given iterator into a  stateful one
--- to be  called repeatedly when  not being used  in a
--- loop.
---
--- The function is used  for its side effects, keeping
--- tabs   on  the   state  internally.   This  version
--- suppresses the state  which makes it non-compatible
--- with other functions from this library.
---
--- <pre>
--- local iterator = with_suppressed_state(iterate({'a', 'b', 'c'}))
--- iterator() -- 'a'
--- iterator() -- 'b'
--- iterator() -- 'c'
--- </pre>
---
--- @param generator function
--- @param parameter any
--- @param state any
--- @return Iterator
local with_suppressed_state = function (generator, parameter, state)
   local function return_and_retain_state(state_x, ...)
      state = state_x

      if state == nil then
         return nil
      end

      return ...
   end

   local function state_generator ()
      return return_and_retain_state(generator(parameter, state))
   end

   return wrap(state_generator)
end

--- Transforms the  given iterator into a  stateful one
--- to be  called repeatedly when  not being used  in a
--- loop.
---
--- <pre>
--- local iterator = iterate({'a', 'b', 'c'}):with_state()
--- iterator() -- 1   'a'
--- iterator() -- 2   'b'
--- iterator() -- 3   'c'
--- </pre>
---
--- The function is used  for its side effects, keeping
--- tabs on  the state  internally. This  version keeps
--- returning the state so it can be chained with other
--- functions from this library.
---
--- <pre>
--- with_state(generator, parameter, state):foreach(print)
--- </pre>
---
--- @return Iterator
function Iterator:with_state ()
   return with_state(self.generator, self.parameter, self.state)
end

--- Transforms the  given iterator into a  stateful one
--- to be  called repeatedly when  not being used  in a
--- loop.
---
--- The function is used  for its side effects, keeping
--- tabs   on  the   state  internally.   This  version
--- suppresses the state  which makes it non-compatible
--- with other functions from this library.
---
--- <pre>
--- local iterator = iterate({'a', 'b', 'c'}):with_suppressed_state()
--- iterator() -- 'a'
--- iterator() -- 'b'
--- iterator() -- 'c'
--- </pre>
---
--- @return Iterator
function Iterator:with_suppressed_state ()
   return with_suppressed_state(self.generator, self.parameter, self.state)
end

-- TODO(scheatkode): Remove when no longer used
local export0 = function (f)
   return function (generator, parameter, state)
      return f(raw_iterator(generator, parameter, state))
   end
end

-- TODO(scheatkode): Remove when no longer used
local export1 = function (f)
   return function (arg1, generator, parameter, state)
      return f(arg1, raw_iterator(generator, parameter, state))
   end
end

-- TODO(scheatkode): Remove when no longer used
local export2 = function (f)
   return function (arg1, arg2, generator, parameter, state)
      return f(arg1, arg2, raw_iterator(generator, parameter, state))
   end
end

module.foreach  = export1(foreach)
module.iterate  = iterate
module.stateful = with_state
module.wrap     = wrap
module.unwrap   = unwrap

--- # Finite generators {{{1
---
--- This section contains a number of useful generators
--- modeled after  Standard ML, Haskell,  Python, Ruby,
--- JavaScript and other languages.

--- Get  the  iterator   function  from  ipairs,  whose
--- signature is:
---
--- <pre>
--- function (table: V[], i?: integer):integer, V
--- <pre>
---
--- @generic V
--- @type fun(table: V[], i?: integer):integer, V
local ipairs_generator = ipairs({})

--- Get the iterator function from pairs, such that its
--- signature is:
---
--- <pre>
--- function (table: table<K, V>, index?: K):K, V
--- </pre>
---
--- @generic K
--- @generic V
--- @type fun(table: table<K, V>, index?: K):K, V
local pairs_generator = pairs({})

--- Nil generator.
---
--- @param  _parameter any
--- @param  _state     any
--- @return nil
nil_generator = function (_parameter, _state)
   return nil
end

--- String generator.
---
--- @param  parameter any
--- @param  state number
--- @return nil
--- @return number, string
string_generator = function (parameter, state)
   state = state + 1

   if state > #parameter then
      return nil
   end

   return state, ssub(parameter, state, state)
end

--- Hashmap generator.
---
--- @param  map table
--- @param  key any
--- @return any, any, any
hashmap_generator = function (map, key)
   local value

   key, value = pairs_generator(map, key)

   return key, key, value
end

--- @param  parameter_x any
--- @param  state_x any
--- @return nil
--- @return number, number
local range_generator = function (parameter_x, state_x)
   local stop, step = parameter_x[1], parameter_x[2]

   state_x = state_x + step

   if state_x > stop then
      return nil
   end

   return state_x, state_x
end

--- @param  parameter_x any
--- @param  state_x     any
--- @return nil
--- @return number, number
local range_reverse_generator = function (parameter_x, state_x)
   local stop, step = parameter_x[1], parameter_x[2]

   state_x = state_x + step

   if state_x < stop then
      return nil
   end

   return state_x, state_x
end

--- Returns   an   iterator    to   create   arithmetic
--- progressions. Iteration values are generated within
--- a  given  closed  interval  `[start,  stop]`  (i.e.
--- `stop`  is included).  If the  `start` argument  is
--- omitted, it defaults  to `1` when `stop >  0` or to
--- `-1` when  `stop <  0`. If  the `step`  argument is
--- omitted, it defaults to `1` when `start <= stop` or
--- to `-1` when `start > stop`. If `step` is positive,
--- the last element is the  largest `start + i * step`
--- less  than  or  equal   to  `stop`;  if  `step`  is
--- negative, the last element is the smallest `start +
--- i * step`  greater than or equal  to `stop`. `step`
--- must not be zero, in which case an error is raised.
--- range(0) always returns an empty iterator.
---
--- @param  start number
--- @param  stop number
--- @param  step number
--- @return Iterator
local range = function (start, stop, step)
   if step == nil then
      if stop == nil then
         if start == 0 then
            return nil_generator, nil, nil
         end

         stop  = start
         start = stop > 0 and 1 or -1
      end

      step = start <= stop and 1 or -1
   end

   assert(type(start) == 'number', 'start must be a number')
   assert(type(stop)  == 'number',  'stop must be a number')
   assert(type(step)  == 'number',  'step must be a number')
   assert(step ~= 0,                'step must not be zero')

   if step > 0 then
      return wrap(range_generator, {stop, step}, start - step)
   elseif step < 0 then
      if stop > start then
         start, stop = stop, start
      end

      return wrap(range_reverse_generator, {stop, step}, start - step)
   end
end
module.range = range

--- # Infinite generators {{{1
---
--- This section contains a number of useful generators
--- modeled after  Standard ML, Haskell,  Python, Ruby,
--- JavaScript and other languages.

--- @param  parameter_x table
--- @param  state_x number
--- @return number, ...
local duplicate_table_generator = function (parameter_x, state_x)
   return state_x + 1, unpack(parameter_x)
end

--- @param  parameter_x function
--- @param  state_x number
--- @return number, any
local duplicate_function_generator = function (parameter_x, state_x)
   return state_x + 1, parameter_x(state_x)
end

--- @param  parameter_x any
--- @param  state_x number
--- @return number, any
local duplicate_generator = function (parameter_x, state_x)
   return state_x + 1, parameter_x
end

--- Creates an  iterator that  returns values  over and
--- over again indefinitely. All values that are passed
--- to  the  iterator  are returned  as-is  during  the
--- iteration.
---
--- @vararg ...
--- @return Iterator
local duplicate = function (...)
   if select('#', ...) <= 1 then
      return wrap(duplicate_generator, select(1, ...), 0)
   else
      return wrap(duplicate_table_generator, {...}, 0)
   end
end
module.duplicate = duplicate
module.replicate = duplicate
module.xrepeat   = duplicate

--- The iterator  that returns `f(0)`,  `f(1)`, `f(2)`,
--- ... values indefinitely.
---
--- NOTE:  the   given  argument  should  be   a  unary
---        generating function.
---
--- NOTE:  if the  function is  a closure  and modifies
---        state,  the resulting  iterator will  not be
---        stateless.
---
--- @param  f function
--- @return Iterator
local tabulate = function (f)
   assert(type(f) == 'function')
   return wrap(duplicate_function_generator, f, 0)
end
module.tabulate      = tabulate
module.from_function = tabulate

--- Creates an infinite iterator  that will yield zeros
--- as an alias to calling `duplicate(0)`.
---
--- @return Iterator
local zeros = function ()
   return wrap(duplicate_generator, 0, 0)
end
module.zeros = zeros

--- Creates an  infinite iterator that will  yield ones
--- as an alias to calling `duplicate(1)`.
---
--- @return Iterator
local ones = function ()
   return wrap(duplicate_generator, 1, 0)
end
module.ones = ones

local random_generator = function(parameter, _)
   return 0, mrandom(parameter[1], parameter[2])
end

local random_nil_generator = function (_, _)
   return 0, mrandom()
end

--- # Random sampling {{{1

--- Creates  an  iterator  that returns  random  values
--- using `math.random()`. If `n` and `m` are set, then
--- the iterator returns  pseudo-random integers in the
--- `[n, m]` interval where `m` is not included. If `m`
--- is   not   set    then   the   iterator   generates
--- pseudo-random  integers in  the `[0,  n]` interval.
--- When    called     without    arguments,    returns
--- pseudo-random    real    numbers    with    uniform
--- distribution in the `[0, 1]` interval.
---
--- @param  n number
--- @param  m number
--- @return Iterator
local random = function (n, m)
   if n == nil and m == nil then
      return wrap(random_nil_generator, 0, 0)
   end

   assert(type(n) == 'number', 'invalid first argument to random')

   if m == nil then
      m = n
      n = 0
   else
      assert(type(m) == 'number', 'invalid second argument to random')
   end

   assert(n < m, 'empty interval')

   return wrap(random_generator, {n, m - 1}, 0)
end
module.random = random

--- # Slicing {{{1

--- This  function returns  the `n`-th  element of  the
--- iterator. If  the iterator does not  have an `n`-th
--- element, then `nil` is returned.
---
--- @param  n number
--- @param  generator function
--- @param  parameter any
--- @param  state any
--- @return nil
--- @return any
local nth = function (n, generator, parameter, state)
   assert(n > 0, 'invalid first argument to nth')

   -- An optimization for arrays and strings
   if generator == ipairs_generator then
      return parameter[n]
   elseif generator == string_generator then
      if n <= #parameter then
         return ssub(parameter, n, n)
      else
         return nil
      end
   end

   for _ = 1, n - 1, 1 do
      state = generator(parameter, state)

      if state == nil then
         return nil
      end
   end

   return return_if_not_empty(generator(parameter, state))
end
module.nth = export1(nth)

--- This  method  returns  the `n`-th  element  of  the
--- iterator. If  the iterator does not  have an `n`-th
--- element, then `nil` is returned.
---
--- @param  n number
--- @return nil
--- @return any
function Iterator:nth(n)
   return nth(n, self.generator, self.parameter, self.state)
end

--- @param  state any
--- @vararg ...
--- @return nil
--- @return ...
local head_call = function(state, ...)
   if state == nil then
      error('head: iterator is empty')
   end

   return ...
end

--- Extract the  first element of the  iterator. If the
--- iterator is empty, an error is raised.
---
--- @param generator function
--- @param parameter any
--- @param state any
--- @return nil
--- @return any
local head = function (generator, parameter, state)
   return head_call(generator(parameter, state))
end
module.head = export0(head)
module.car  = module.head

--- Extract the  first element of the  iterator. If the
--- iterator is empty, an error is raised.
---
--- @return nil
--- @return any
function Iterator:head()
   return head(self.generator, self.parameter, self.state)
end

--- Return  a copy  of the  given iterator  without its
--- first  element. If  the iterator  is empty  then an
--- empty iterator is returned.
---
--- @param  generator function
--- @param  parameter any
--- @param  state any
--- @return Iterator
local tail = function (generator, parameter, state)
   state = generator(parameter, state)

   if state == nil then
      return wrap(nil_generator, nil, nil)
   end

   return wrap(generator, parameter, state)
end
module.tail = export0(tail)
module.cdr  = module.tail

--- Return  a copy  of the  given iterator  without its
--- first  element. If  the iterator  is empty  then an
--- empty iterator is returned.
---
--- @return nil
--- @return any
function Iterator:tail()
   return tail(self.generator, self.parameter, self.state)
end

--- # Subsequences {{{1

--- @param  i number
--- @param  state_x any
--- @vararg ...
--- @return table, ...
local take_n_generator_x = function (i, state_x, ...)
   if state_x == nil then
      return nil
   end

   return {i, state_x}, ...
end

--- @param  parameter table
--- @param  state table
--- @return any
local take_n_generator = function (parameter, state)
   local n, generator_x, parameter_x = parameter[1], parameter[2], parameter[3]
   local i, state_x = state[1], state[2]

   if i >= n then
      return nil
   end

   return take_n_generator_x(i + 1, generator_x(parameter_x, state_x))
end

--- Returns an iterator on the subsequence of first `n`
--- elements.
---
--- @param  n number
--- @param  generator function
--- @param  parameter any
--- @param  state any
--- @return Iterator
local take_n = function (n, generator, parameter, state)
   assert(n >= 0,  'invalid first argument to take_n')
   return wrap(take_n_generator, {n, generator, parameter}, {0, state})
end
module.take_n = export1(take_n)

--- Returns an iterator on the subsequence of first `n`
--- elements.
---
--- @param  n number
--- @return Iterator
function Iterator:take_n(n)
   return take_n(n, self.generator, self.parameter, self.state)
end

--- @param  f function
--- @param  state_x any
--- @vararg ...
--- @return nil
--- @return any
--- @return ...
local take_while_generator_x = function (f, state_x, ...)
   if state_x == nil or not f(...) then
      return nil
   end

   return state_x, ...
end

--- @param  parameter table
--- @param  state any
--- @return any
local take_while_generator = function (parameter, state)
   local f, generator_x, parameter_x = parameter[1], parameter[2], parameter[3]
   return take_while_generator_x(f, generator_x(parameter_x, state))
end

--- @param  predicate function
--- @param  generator function
--- @param  parameter any
--- @param  state any
--- @return Iterator
local take_while = function (predicate, generator, parameter, state)
   assert(type(predicate) == 'function', 'invalid first argument to take_while')
   return wrap(take_while_generator, {predicate, generator, parameter}, state)
end
module.take_while = export1(take_while)

--- Returns  an  iterator  on  the  longest  prefix  of
--- elements  that satify  the given  function used  as
--- predicate.
---
--- @param  predicate function
--- @return Iterator
function Iterator:take_while(predicate)
   return take_while(predicate, self.generator, self.parameter, self.state)
end

--- Returns  an  iterator  on  the  longest  prefix  of
--- elements  that satify  the given  function used  as
--- predicate.
---
--- @param  n_or_predicate function
--- @return Iterator
local take = function (n_or_predicate, generator, parameter, state)
   if type(n_or_predicate) == 'number' then
      return take_n(n_or_predicate, generator, parameter, state)
   else
   return take_while(n_or_predicate, generator, parameter, state)
   end
end
module.take = export1(take)

--- An  alias for  `take_n()`  and `take_while()`  that
--- autodetects   the   required  function   based   on
--- `n_or_predicate`'s type.
---
--- @param  n_or_predicate number|function
--- @return nil
--- @return any
function Iterator:take(n_or_predicate)
   return take(n_or_predicate, self.generator, self.parameter, self.state)
end

--- Returns an  iterator after  skipping the  first `n`
--- elements.
---
--- @param  n number
--- @param  generator function
--- @param  parameter any
--- @param  state any
--- @return Iterator
local drop_n = function (n, generator, parameter, state)
   assert(n >= 0, 'invalid first argument to drop_n')

   for _ = 1, n, 1 do
      state = generator(parameter, state)

      if state == nil then
         return wrap (nil_generator, nil, nil)
      end
   end

   return wrap(generator, parameter, state)
end
module.drop_n = export1(drop_n)

--- Returns an  iterator after  skipping the  first `n`
--- elements.
---
--- @param  n number
--- @return Iterator
function Iterator:drop_n(n)
   return drop_n(n, self.generator, self.parameter, self.state)
end

--- @param  predicate function
--- @param  state any
--- @vararg ...
--- @return any
--- @return boolean
--- @return ...
local drop_while_x = function(predicate, state, ...)
   if state == nil or not predicate(...) then
      return state, false
   end

   return state, true, ...
end

--- Return  an  iterator  after  skipping  the  longest
--- prefix of elements that satisfy predicate.
---
--- @param  predicate function
--- @param  generator function
--- @param  parameter any
--- @param  state any
--- @return Iterator
local drop_while = function(predicate, generator, parameter, state)
   assert(type(predicate) == 'function', 'invalid first argument to drop_while')

   local continue, state_previous

   repeat
      state_previous  = deepcopy(state)
      state, continue = drop_while_x(predicate, generator(parameter, state))
   until not continue

   if state == nil then
      return wrap(nil_generator, nil, nil)
   end

   return wrap(generator, parameter, state_previous)
end
module.drop_while = export1(drop_while)

--- Return  an  iterator  after  skipping  the  longest
--- prefix of elements that satisfy predicate.
---
--- @param  predicate function
--- @return Iterator
function Iterator:drop_while(predicate)
   return drop_while(predicate, self.generator, self.parameter, self.state)
end

--- An  alias for  `drop_n()`  and `drop_while()`  that
--- autodetects   the   required  function   based   on
--- `n_or_predicate`'s type.
---
--- @param  n_or_predicate number|function
--- @param  generator function
--- @param  parameter any
--- @param  state any
--- @return Iterator
local drop = function (n_or_predicate, generator, parameter, state)
   if type(n_or_predicate) == 'number' then
      return drop_n(n_or_predicate, generator, parameter, state)
   else
      return drop_while(n_or_predicate, generator, parameter, state)
   end
end
module.drop = export1(drop)

--- An  alias for  `drop_n()`  and `drop_while()`  that
--- autodetects   the   required  function   based   on
--- `n_or_predicate`'s type.
---
--- @param  n_or_predicate number|function
--- @return Iterator
function Iterator:drop(n_or_predicate)
   return drop(n_or_predicate, self.generator, self.parameter, self.state)
end

--- Return  an  iterator  pair   where  the  first  one
--- operates on the longest,  possible empty, prefix of
--- the  iterator of  elements that  satisfy the  given
--- predicate and the second  operates the remainder of
--- the iterator. This is equivalent to:
---
--- <pre>
--- return take(n_or_predicate, generator, parameter, state),
---        drop(n_or_predicate, generator, parameter, state);
--- </pre>
---
--- @param  n_or_predicate function
--- @param  generator function
--- @param  parameter any
--- @param  state any
--- @return Iterator, Iterator
local split_p = function (n_or_predicate, generator, parameter, state)
   return take(n_or_predicate, generator, parameter, state),
          drop(n_or_predicate, generator, parameter, state)
end
module.split_p  = export1(split_p)
module.split_at = module.split_p
module.span     = module.split_p

--- Return  an  iterator  pair   where  the  first  one
--- operates on the longest,  possible empty, prefix of
--- the  iterator of  elements that  satisfy the  given
--- predicate and the second  operates the remainder of
--- the iterator.
---
--- @param  n_or_predicate number|function
--- @return nil
--- @return any
function Iterator:split_p(n_or_predicate)
   return split_p(n_or_predicate, self.generator, self.parameter, self.state)
end

--- @param  parameter table
--- @param  state number
--- @return nil
--- @return number, string
local string_split_generator = function (parameter, state)
   local input, separator = parameter[1], parameter[2]
   local length = #input

   if state > length + 1 then
      return nil
   end

   local start, finish = sfind(input, separator, state, true)

   if not start then
      start  = length + 1
      finish = length + 1
   end

   local substring = input:sub(state, start - 1)

   return finish + 1, substring
end

--- Return  an iterator  of substrings  separated by  a
--- string.
---
--- @param  input string
--- @param  separator string
--- @param  state number
--- @return Iterator
local split = function (input, separator, state)
   assert(type(input) == 'string', 'split should be called only on strings')
   return wrap(string_split_generator, {input, separator}, state or 1)
end
module.split = split

--- Return  an iterator  of substrings  separated by  a
--- string.
---
--- @param separator string
---
--- @return nil
--- @return table
function Iterator:split(separator)
   return split(self.parameter, separator, self.state)
end

--- Splits a string based on a single space.
--- An alias for split(input, ' ').
---
--- @param input any
--- @param state number
---
--- @return nil
--- @return table
local words = function (input, state)
   return split(input, ' ', state)
end
module.words = words

--- Splits a string based on a single space.
--- An alias for split(input, ' ').
---
--- @return nil
--- @return table
function Iterator:words()
   return words(self.parameter, self.state)
end

--- Splits a string based on line separators.
--- An alias for split(input, '\n').
---
--- @param input string
--- @param state number
---
--- @return nil
--- @return table
local lines = function (input, state)
   -- TODO(scheatkode): platform specific linebreaks
   return split(input, '\n', state)
end
module.lines = lines

--- Splits a string based on line separators.
--- An alias for split(input, '\n').
---
--- @return nil
--- @return table
function Iterator:lines()
   return lines(self.parameter, self.state)
end

--- # Indexing {{{1
---
--- This section contains functions to find elements by
--- their values.

--- Returns the  position of  the first element  in the
--- given iterator which  is equal to `x`,  or `nil` if
--- there is no such element.
---
--- @param  x any
--- @param  generator function
--- @param  parameter any
--- @param  state any
--- @return nil
--- @return number
local index = function (x, generator, parameter, state)
   local i = 1

   for _, v in generator, parameter, state do
      if v == x then
         return i
      end

      i = i + 1
   end

   return nil
end
module.index      = export1(index)
module.index_of   = module.index
module.elem_index = module.index

--- Returns the  position of  the first element  in the
--- given iterator which  is equal to `x`,  or `nil` if
--- there is no such element.
---
--- @param  x any
--- @return nil
--- @return number
function Iterator:index(x)
   return index(x, self.generator, self.parameter, self.state)
end

--- @param  parameter table
--- @param  state table
--- @return nil
--- @return table, number
local indexes_generator = function (parameter, state)
   local x, generator_x, parameter_x = parameter[1], parameter[2], parameter[3]
   local i, state_x = state[1], state[2]
   local v

   while true do
      state_x, v = generator_x(parameter_x, state_x)

      if state_x == nil then
         return nil
      end

      i = i + 1

      if v == x then
         return {i, state_x}, i
      end
   end
end

--- Returns an iterator to  positions of elements which
--- equal `x`.
---
--- @param  x any
--- @param  generator function
--- @param  parameter any
--- @param  state any
--- @return Iterator
local indexes = function (x, generator, parameter, state)
   return wrap(indexes_generator, {x, generator, parameter}, {0, state})
end
module.indexes = export1(indexes)
module.indices = module.indexes

--- Returns an iterator to  positions of elements which
--- equal `x`.
---
--- @param  x any
--- @return Iterator
function Iterator:indexes(x)
   return indexes(x, self.generator, self.parameter, self.state)
end

--- # Filtering {{{1
---
--- This  section contains  functions to  filter values
--- during iteration, using a predicate.

local filter1_generator = function (f, generator, parameter, state, a)
   while true do
      if state == nil or f(a) then
         break
      end

      state, a = generator(parameter, state)
   end

   return state, a
end

local filterm_generator_shrink = function (f, generator, parameter, state)
   return filterm_generator(f, generator, parameter, generator(parameter, state))
end

filterm_generator = function (f, generator, parameter, state, ...)
   if state == nil then
      return nil
   end

   if f(...) then
      return state, ...
   end

   return filterm_generator_shrink(f, generator, parameter, state)
end

local filter_detect = function (f, generator, parameter, state, ...)
   if select('#', ...) < 2 then
      return filter1_generator(f, generator, parameter, state, ...)
   else
      return filterm_generator(f, generator, parameter, state, ...)
   end
end

local filter_generator = function (parameter, state_x)
   local f, generator_x, parameter_x = parameter[1], parameter[2], parameter[3]

   return filter_detect(
      f,
      generator_x,
      parameter_x,
      generator_x(parameter_x, state_x)
   )
end

--- Return  a  new  iterator  of  those  elements  that
--- satisfy the given `predicate`.
---
--- @param  predicate function
--- @param  generator function
--- @param  parameter any
--- @param  state any
--- @return Iterator
local filter = function (predicate, generator, parameter, state)
   return wrap(filter_generator, {predicate, generator, parameter}, state)
end
module.filter = export1(filter)

--- Return  a  new  iterator  of  those  elements  that
--- satisfy the given `predicate`.
---
--- @param  predicate function
--- @return Iterator
function Iterator:filter(predicate)
   return filter(predicate, self.generator, self.parameter, self.state)
end

--- If `regex_or_predicate` is a string then it is used
--- as  a  regular  expression  to  build  a  filtering
--- predicate. Otherwise the function  is just an alias
--- for `filter()`.
---
--- @param  regex_or_predicate string|function
--- @param  generator function
--- @param  parameter any
--- @param  state any
--- @return Iterator
local grep = function (regex_or_predicate, generator, parameter, state)
   local f = regex_or_predicate

   if type(regex_or_predicate) == 'string' then
      f = function (x) return sfind(x, regex_or_predicate) ~= nil end
   end

   return filter(f, generator, parameter, state)
end
module.grep = export1(grep)

--- If `regex_or_predicate` is a string then it is used
--- as  a  regular  expression  to  build  a  filtering
--- predicate. Otherwise the function  is just an alias
--- for `filter()`.
---
--- @param  regex_or_predicate string|function
--- @return Iterator
function Iterator:grep(regex_or_predicate)
   return grep(
      regex_or_predicate,
      self.generator,
      self.parameter,
      self.state
   )
end

--- Returns two iterators where  elements do and do not
--- satisfy the given predicate.
---
--- @param  predicate function
--- @param  generator function
--- @param  parameter any
--- @param  state any
--- @return Iterator, Iterator
local partition = function (predicate, generator, parameter, state)
   local negative_p = function (...)
      return not predicate(...)
   end

   return filter(predicate,  generator, parameter, state),
          filter(negative_p, generator, parameter, state)
end
module.partition = export1(partition)

--- Returns two iterators where  elements do and do not
--- satisfy the given predicate.
---
--- @param  predicate function
--- @return Iterator, Iterator
function Iterator:partition(predicate)
   return partition(predicate, self.generator, self.parameter, self.state)
end

--- # Reducing {{{1}
---
--- This   section   contains  functions   to   analyze
--- iteration values  and recombine,  through use  of a
--- given   combining   operation,   the   results   of
--- recursively   processing  its   constituent  parts,
--- building up a return value.

--- @param f function
--- @param start any
--- @param state any
local foldl_call = function (f, start, state, ...)
   if state == nil then
      return nil, start
   end

   return state, f(start, ...)
end

--- Reduce the  iterator from  left to right  using the
--- binary operator `accumulator` and the initial value
--- `start`. It is equivalent to:
---
--- <pre>
--- local val = start
---
--- for _, ... in generator, parameter, state do
---     val = accumulator(val, ...)
--- end
---
--- return val
--- </pre>
---
--- @param  accumulator function
--- @param  start any
--- @param  generator function
--- @param  parameter any
--- @param  state any
--- @return any
local reduce = function (accumulator, start, generator, parameter, state)
   while true do
      state, start = foldl_call(accumulator, start, generator(parameter, state))

      if state == nil then
         break
      end
   end

   return start
end
module.reduce = export2(reduce)
module.foldl  = module.reduce

--- Reduce the  iterator from  left to right  using the
--- binary operator `accumulator` and the initial value
--- `start`. It is equivalent to:
---
--- <pre>
--- local val = start
---
--- for _, ... in generator, parameter, state do
---     val = accumulator(val, ...)
--- end
---
--- return val
--- </pre>
---
--- @param  accumulator function
--- @param  start any
--- @return any
function Iterator:reduce(accumulator, start)
   return reduce(
      accumulator,
      start,
      self.generator,
      self.parameter,
      self.state
   )
end

--- Return the number of elements in the iterator. This
--- is  equivalent to  using  `#object` for  elementary
--- arrays and string generators.
---
--- NOTE:  An  attempt  to  call this  function  on  an
---       infinite  iterator  will result  an  infinite
---       loop.
---
--- NOTE: This  function has `O(n)` complexity  for all
---       iterators  except  basic   array  and  string
---       iterators.
---
--- @param  generator function
--- @param  parameter any
--- @param  state any
--- @return number
local length = function (generator, parameter, state)
   if
         generator == ipairs_generator
      or generator == string_generator
   then
      return #parameter
   end

   local length = 0

   repeat
      state  = generator(parameter, state)
      length = length + 1
   until state == nil

   return length - 1
end
module.length = export0(length)

--- Return the number of elements in the iterator. This
--- is  equivalent to  using  `#object` for  elementary
--- arrays and string generators.
---
--- NOTE:  An  attempt  to  call this  function  on  an
---       infinite  iterator  will result  an  infinite
---       loop.
---
--- NOTE: This  function has `O(n)` complexity  for all
---       iterators  except  basic   array  and  string
---       iterators.
---
--- @return number
function Iterator:length()
   return length(self.generator, self.parameter, self.state)
end

--- Returns  `true`  when  the  iterator  is  empty  or
--- finished, `false` otherwise.
---
--- @param  generator function
--- @param  parameter any
--- @param  state any
--- @return boolean
local is_null = function (generator, parameter, state)
   return generator(parameter, deepcopy(state)) == nil
end
module.is_null = export0(is_null)

--- Returns  `true`  when  the  iterator  is  empty  or
--- finished, `false` otherwise.
---
--- @return boolean
function Iterator:is_null()
   return is_null(self.generator, self.parameter, self.state)
end

--- Takes two iterators and returns `true` if the first
--- iterator is a prefix of the second.
---
--- @param  iter_x Iterator
--- @param  iter_y Iterator
--- @return boolean
local is_prefix_of = function (iter_x, iter_y)
   local generator_x, parameter_x, state_x = iterate(iter_x)
   local generator_y, parameter_y, state_y = iterate(iter_y)

   local v_x, v_y

   for _ = 1, 10, 1 do
      state_x, v_x = generator_x(parameter_x, state_x)
      state_y, v_y = generator_y(parameter_y, state_y)

      if state_x == nil then
         return true
      end

      if state_y == nil or v_x ~= v_y then
         return false
      end
   end
end
module.is_prefix_of = is_prefix_of

--- Takes two iterators and returns `true` if the first
--- iterator is a prefix of the second.
---
--- @param  iter Iterator
--- @return boolean
function Iterator:is_prefix_of(iter)
   return is_prefix_of(self, iter)
end

--- Returns `true`  if all return values  of `iterator`
--- satisfy the given predicate.
---
--- @param  predicate function
--- @param  generator function
--- @param  parameter any
--- @param  state any
--- @return boolean
local every = function (predicate, generator, parameter, state)
   local v

   repeat
      state, v = call_if_not_empty(predicate, generator(parameter, state))
   until state == nil or not v

   return state == nil
end
module.every = export1(every)
module.all   = module.every

--- Returns `true`  if all return values  of `iterator`
--- satisfy the given predicate.
---
--- @param  predicate function
--- @return boolean
function Iterator:every(predicate)
   return every(predicate, self.generator, self.parameter, self.state)
end

--- Returns  `true` if  at least  one return  values of
--- iterator satisfy the given predicate. The iteration
--- stops on the first value that matches.
---
--- @param  predicate function
--- @param  generator function
--- @param  parameter any
--- @param  state any
--- @return boolean
local any = function (predicate, generator, parameter, state)
   local v

   repeat
      state, v = call_if_not_empty(predicate, generator(parameter, state))
   until state == nil or v

   return not not v
end
module.any  = export1(any)
module.some = module.any

--- Returns  `true` if  at least  one return  values of
--- iterator satisfy the given predicate. The iteration
--- stops on the first value that matches.
---
--- @param  predicate function
--- @return boolean
function Iterator:any(predicate)
   return any(predicate, self.generator, self.parameter, self.state)
end

--- Sum  up all  iteration values.  An optimized  alias
--- for:
---
--- <pre>
--- reduce(operator.add, 0, gen, param, state)
--- </pre>
---
--- 0 is returned for empty iterators.
---
--- @param  generator function
--- @param  parameter any
--- @param  state any
--- @return number
local sum = function (generator, parameter, state)
   local s = 0
   local v = 0

   repeat
      s = s + v
      state, v = generator(parameter, state)
   until state == nil

   return s
end
module.sum = export0(sum)

--- Sum  up all  iteration values.  An optimized  alias
--- for:
---
--- <pre>
--- reduce(operator.add, 0, gen, param, state)
--- </pre>
---
--- 0 is returned for empty iterators.
---
--- @return number
function Iterator:sum()
   return sum(self.generator, self.parameter, self.state)
end

--- Multiply  up  all  iteration values.  An  optimized
--- alias for:
---
--- <pre>
--- reduce(operator.mul, 1, gen, param, state)
--- </pre>
---
--- 1 is returned for empty iterators.
---
--- @param  generator function
--- @param  parameter any
--- @param  state any
--- @return number
local product = function (generator, parameter, state)
   local p = 1
   local v = 1

   repeat
      p = p * v
      state, v = generator(parameter, state)
   until state == nil

   return p
end
module.product = export0(product)

--- Multiply  up  all  iteration values.  An  optimized
--- alias for:
---
--- <pre>
--- reduce(operator.mul, 1, gen, param, state)
--- </pre>
---
--- 1 is returned for empty iterators.
---
--- @return number
function Iterator:product()
   return product(self.generator, self.parameter, self.state)
end

local min_cmp = function (m, n)
   if n < m then return n else return m end
end

local max_cmp = function (m, n)
   if n > m then return n else return m end
end

--- Returns the  smallest value  of the  iterator using
--- `operator.min()` for numbers or `<` for other types
--- respectively.  The   iterator  must   be  non-null,
--- otherwise an error is raised.
---
--- @param  generator function
--- @param  parameter any
--- @param  state any
--- @return any
local minimum = function (generator, parameter, state)
   local state_x, m = generator(parameter, state)

   if state_x == nil then
      error('min: iterator is empty')
   end

   local cmp

   if type(m) == 'number' then
      -- An optimization: use math.min for numbers
      cmp = mmin
   else
      cmp = min_cmp
   end

   for _, v in generator, parameter, state_x do
      m = cmp(m, v)
   end

   return m
end
module.minimum = export0(minimum)

--- Returns the  smallest value  of the  iterator using
--- `operator.min()` for numbers or `<` for other types
--- respectively.  The   iterator  must   be  non-null,
--- otherwise an error is raised.
---
--- @return any
function Iterator:minimum()
   return minimum(self.generator, self.parameter, self.state)
end

--- Returns the  smallest value  of the  iterator using
--- `predicate` as a  comparison operator. The iterator
--- must be non-null, otherwise an error is raised.
---
--- @param  predicate function
--- @param  generator function
--- @param  parameter any
--- @param  state any
--- @return any
local minimum_by = function (predicate, generator, parameter, state)
   local state_x, m = generator(parameter, state)

   if state_x == nil then
      error('min: iterator is empty')
   end

   for _, v in generator, parameter, state_x do
      m = predicate(m, v)
   end

   return m
end
module.minimum_by = export1(minimum_by)

--- Returns the  smallest value  of the  iterator using
--- `predicate` as a  comparison operator. The iterator
--- must be non-null, otherwise an error is raised.
---
--- @param  predicate function
--- @return any
function Iterator:minimum_by(predicate)
   return minimum_by(predicate, self.generator, self.parameter, self.state)
end

--- Returns the  biggest value from the  iterator using
--- `operator.max()`  for  numbers  and `>`  for  other
--- types.
---
--- @param  generator function
--- @param  parameter any
--- @param  state any
--- @return any
local maximum = function (generator, parameter, state)
   local state_x, m = generator(parameter, state)

   if state_x == nil then
      error('max: iterator is empty')
   end

   local cmp

   if type(m) == 'number' then
      -- An optimization: use math.max for numbers
      cmp = mmax
   else
      cmp = max_cmp
   end

   for _, v in generator, parameter, state_x do
      m = cmp(m, v)
   end

   return m
end
module.maximum = export0(maximum)

--- Returns the  biggest value from the  iterator using
--- `operator.max()`  for  numbers  and `>`  for  other
--- types. The iterator must  be non-null, otherwise an
--- error is raised.
---
--- @return any
function Iterator:maximum()
   return maximum(self.generator, self.parameter, self.state)
end

--- Returns  the biggest  value of  the iterator  using
--- `predicate` as a  comparison operator. The iterator
--- must be non-null, otherwise an error is raised.
---
--- @param  predicate function
--- @param  generator function
--- @param  parameter any
--- @param  state any
--- @return any
local maximum_by = function (predicate, generator, parameter, state)
   local state_x, m = generator(parameter, state)

   if state_x == nil then
      error('max: iterator is empty')
   end

   for _, v in generator, parameter, state_x do
      m = predicate(m, v)
   end

   return m
end
module.maximum_by = export1(maximum_by)

--- Returns  the biggest  value of  the iterator  using
--- `predicate` as a  comparison operator. The iterator
--- must be non-null, otherwise an error is raised.
---
--- @param  predicate function
--- @return any
function Iterator:maximum_by(predicate)
   return maximum_by(predicate, self.generator, self.parameter, self.state)
end

--- Reduces  the  iterator  from left  to  right  using
--- `table.insert`.
---
--- @param  generator function
--- @param  parameter any
--- @param  state any
--- @return table
local totable = function (generator, parameter, state)
   local t, v = {}, nil

   while true do
      state, v = generator(parameter, state)

      if state == nil then
         break
      end

      table.insert(t, v)
   end

   return t
end
module.totable = export0(totable)

--- Reduces  the  iterator  from left  to  right  using
--- `table.insert`.
---
--- @return table
function Iterator:totable()
   return totable(self.generator, self.parameter, self.state)
end

--- Reduces the  iterator from  left to right  using by
--- doing `tab[val1] = val2`.
---
--- @param  generator function
--- @param  parameter any
--- @param  state any
--- @return table
local tomap = function (generator, parameter, state)
   local t, k, v = {}, nil, nil

   while true do
      state, k, v = generator(parameter, state)

      if state == nil then
         break
      end

      t[k] = v
   end

   return t
end
module.tomap = export0(tomap)

--- Reduces the  iterator from  left to right  by
--- doing `tab[val1] = val2` for each iteration.
---
--- @return table
function Iterator:tomap()
   return tomap(self.generator, self.parameter, self.state)
end

--- # Transformations {{{1

local map_generator = function (parameter, state)
   local generator_x, parameter_x, f = parameter[1], parameter[2], parameter[3]

   return call_if_not_empty(f, generator_x(parameter_x, state))
end

--- Return  a  new iterator  by  applying  `f` to  each
--- element of  the iterator. The mapping  is performed
--- on the fly and no values are buffered.
---
--- @param  f function
--- @param  generator function
--- @param  parameter any
--- @param  state any
--- @return Iterator
local map = function (f, generator, parameter, state)
   return wrap(map_generator, {generator, parameter, f}, state)
end
module.map = export1(map)

--- Return  a  new iterator  by  applying  `f` to  each
--- element of  the iterator. The mapping  is performed
--- on the fly and no values are buffered.
---
--- @param  f function
--- @return Iterator
function Iterator:map(f)
   return map(f, self.generator, self.parameter, self.state)
end

local enumerate_generator_call = function (i, state_x, ...)
   if state_x == nil then
      return nil
   end

   return {i + 1, state_x}, i, ...
end

local enumerate_generator = function (parameter, state)
   local generator_x, parameter_x = parameter[1], parameter[2]
   local i, state_x = state[1], state[2]

   return enumerate_generator_call(i, generator_x(parameter_x, state_x))
end

--- Return a  new iterator by enumerating  all elements
--- of  the given  iterator  and starting  from 1.  The
--- mapping is performed  on the fly and  no values are
--- buffered.
---
--- @param  generator function
--- @param  parameter any
--- @param  state any
--- @return Iterator
local enumerate = function (generator, parameter, state)
   return wrap(enumerate_generator, {generator, parameter}, {1, state})
end
module.enumerate = export0(enumerate)

--- Return a  new iterator by enumerating  all elements
--- of  the given  iterator  and starting  from 1.  The
--- mapping is performed  on the fly and  no values are
--- buffered.
---
--- @return Iterator
function Iterator:enumerate()
   return enumerate(self.generator, self.parameter, self.state)
end

local intersperse_call = function (i, state_x, ...)
   if state_x == nil then
      return nil
   end

   return {i + 1, state_x}, ...
end

local intersperse_generator = function (parameter, state)
   local x, generator_x, parameter_x = parameter[1], parameter[2], parameter[3]
   local i, state_x = state[1], state[2]

   if i % 2 == 1 then
      return {i + 1, state_x}, x
   else
      return intersperse_call(i, generator_x(parameter_x, state_x))
   end
end

--- Return  a  new  iterator  where the  `x`  value  is
--- interspersed  between the  elements  of the  source
--- iterator. The `x` value can also be added as a last
--- element of  the created  iterator if the  first one
--- contains an odd number of elements.
---
--- @param  generator function
--- @param  parameter any
--- @param  state any
--- @return Iterator
---
--- TODO(scheatkode): intersperse must not add x to the tail
local intersperse = function (x, generator, parameter, state)
   return wrap(intersperse_generator, {x, generator, parameter}, {0, state})
end
module.intersperse = export1(intersperse)

--- Return  a  new  iterator  where the  `x`  value  is
--- interspersed  between the  elements  of the  source
--- iterator. The `x` value can also be added as a last
--- element of  the created  iterator if the  first one
--- contains an odd number of elements.
---
--- @return Iterator
function Iterator:intersperse(x)
   return intersperse(x, self.generator, self.parameter, self.state)
end

--- # Compositions {{{1

local function zip_generator_r (parameter, state, state_new, ...)
   if #state_new == #parameter / 2 then
      return state_new, ...
   end

   local i = #state_new + 1
   local generator_x, parameter_x = parameter[2 * i - 1], parameter[2 * i]
   local state_x, v = generator_x(parameter_x, state[i])

   if state_x == nil then
      return nil
   end

   table.insert(state_new, state_x)

   return zip_generator_r(parameter, state, state_new, v, ...)
end

local zip_generator = function (parameter, state)
   return zip_generator_r(parameter, state, {})
end

--- Return a new iterator where the `i`-th return value
--- contains  the  `i`-th  element  from  each  of  the
--- iterators. The  resulting iterator is  truncated in
--- length to fit the shortest iterator. Only the first
--- variable is used for multi-return iterators.
---
--- @vararg ... Iterator
--- @return Iterator
local zip = function (...)
   local n = count_arguments(...)

   if n == 0 then
      return wrap(nil_generator, nil, nil)
   end

   local parameter = { [2 * n] = 0 }
   local state     = {     [n] = 0 }

   local generator_x, parameter_x, state_x

   for i = 1, n, 1 do
      local it = select(n - i + 1, ...)

      generator_x, parameter_x, state_x = raw_iterator(it)

      parameter[ 2 * i - 1 ] = generator_x
      parameter[ 2 * i ]     = parameter_x
      state[ i ]             = state_x
   end

   return wrap(zip_generator, parameter, state)
end
module.zip = zip

--- Return a new iterator where the `i`-th return value
--- contains  the  `i`-th  element  from  each  of  the
--- iterators. The  resulting iterator is  truncated in
--- length to fit the shortest iterator. Only the first
--- variable is used for multi-return iterators.
---
--- @vararg ... Iterator
--- @return Iterator
Iterator.zip = zip

local cycle_generator_call = function (parameter, state_x, ...)
   if state_x == nil then
      local generator_x, parameter_x, state_x0 = parameter[1], parameter[2], parameter[3]

      return generator_x(parameter_x, deepcopy(state_x0))
   end

   return state_x, ...
end

local cycle_generator = function (parameter, state_x)
   -- local generator_x, parameter_x, state_x0 = parameter[1], parameter[2], parameter[3]
   local generator_x, parameter_x = parameter[1], parameter[2]

   return cycle_generator_call(parameter, generator_x(parameter_x, state_x))
end

--- Make a new iterator  that returns elements from the
--- given  iterator until  the end  and then  “restart”
--- using  a  saved  clone. The  returned  iterator  is
--- constant space  and no return values  are buffered.
--- Instead, the  function makes a clone  of the source
--- iterator, therefore, it must  be pure functional to
--- make  an identical  clone.  Infinity iterators  are
--- supported, but not recommended.
---
--- @param  generator function
--- @param  parameter any
--- @param  state any
--- @return Iterator
local cycle = function (generator, parameter, state)
   return wrap(cycle_generator, {generator, parameter, state}, deepcopy(state))
end
module.cycle = export0(cycle)

--- Make a new iterator  that returns elements from the
--- given  iterator until  the end  and then  “restart”
--- using  a  saved  clone. The  returned  iterator  is
--- constant space  and no return values  are buffered.
--- Instead, the  function makes a clone  of the source
--- iterator, therefore, it must  be pure functional to
--- make  an identical  clone.  Infinity iterators  are
--- supported, but not recommended.
---
--- @return Iterator
function Iterator:cycle()
   return cycle(self.generator, self.parameter, self.state)
end

-- call each other
local chain_generator_r1
local chain_generator_r2 = function (parameter, state, state_x, ...)
   if state_x == nil then
      local i = state[1] + 1

      if parameter[3 * i - 1] == nil then
         return nil
      end

      state_x = parameter[3 * i]

      return chain_generator_r1(parameter, {i, state_x})
   end

   return { state[1], state_x }, ...
end

chain_generator_r1 = function (parameter, state)
   local i, state_x = state[1], state[2]
   local generator_x, parameter_x = parameter[3 * i - 2], parameter[3 * i - 1]

   return chain_generator_r2(parameter, state, generator_x(parameter_x, state_x))
end

--- Make  an iterator  that returns  elements from  the
--- first given  iterator until  it is  exhausted, then
--- proceeds to the next iterator,  and so on until all
--- of  the given  iterators  are  exhausted. Used  for
--- treating consecutive iterators  as a single entity.
--- Infinity   iterators   are   supported,   but   not
--- recommended.
---
--- @vararg ... Iterator
--- @return Iterator
local chain = function (...)
   local n = count_arguments(...)

   if n == 0 then
      return wrap(nil_generator, nil, nil)
   end

   local parameter = { [3 * n] = 0 }
   local it

   for i = 1, n, 1 do
      local element = select(i, ...)

      it = iterate(element)

      parameter[3 * i - 2] = it.generator
      parameter[3 * i - 1] = it.parameter
      parameter[3 * i]     = it.state
   end

   return wrap(chain_generator_r1, parameter, {1, parameter[3]})
end
module.chain = chain

--- Make  an iterator  that returns  elements from  the
--- first given  iterator until  it is  exhausted, then
--- proceeds to the next iterator,  and so on until all
--- of  the given  iterators  are  exhausted. Used  for
--- treating consecutive iterators  as a single entity.
--- Infinity   iterators   are   supported,   but   not
--- recommended.
---
--- @vararg ... Iterator
--- @return Iterator
Iterator.chain = chain

--- # Operators {{{1

local operator = {

   --- ## Comparison operators {{{2

   lt = function (a, b) return a <  b end,
   le = function (a, b) return a <= b end,
   eq = function (a, b) return a == b end,
   ne = function (a, b) return a ~= b end,
   ge = function (a, b) return a >= b end,
   gt = function (a, b) return a >  b end,

   --- ## Arithmetic operators {{{2

   add = function (a, b) return a + b end,
   sub = function (a, b) return a - b end,
   div = function (a, b) return a / b end,
   mod = function (a, b) return a % b end,
   mul = function (a, b) return a * b end,
   pow = function (a, b) return a ^ b end,

   neg = function (a) return -a end,

   floordiv = function (a, b) return mfloor(a / b) end,
   intdiv   = function (a, b)
      local q = a / b

      if a >= 0 then return mfloor(q) else return mceil(q) end
   end,

   --- ## String operators {{{2

   concat = function (a, b) return a .. b end,
   length = function (a) return #a end,

   --- ## Logical operators {{{2

   land = function (a, b) return a and b end,
   lor  = function (a, b) return a or  b end,

   lnot  = function (a) return     not a end,
   truth = function (a) return not not a end,

   --- ## Miscellaneous operators {{{2

   id = function (...) return ... end,

   skip_key   = function (_, v) return v end,
   skip_value = function (k, _) return k end,

}

module.operator = operator
module.op       = operator

--- # Module exports {{{1

return module

-- vim: set fdm=marker fdl=0:

