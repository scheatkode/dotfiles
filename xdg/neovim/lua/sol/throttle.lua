----------------------------------- throttle -----------------------------------
--                                                                            --
--       provides higher order functions for throttling and debouncing.       --
--                                                                            --
--------------------------------------------------------------------------------

--                   =-=-=-=-=-=-=-=-=-)-=-=-=-=-=-=-=-=-=-
--                   _| |__| |________(_________| |__| |___
--                    \  \/  /         )        \  \/  /
--                     )    (         (          )    (
--                     |    |         (          |    |
--                     |    |          \|        |    |
--                     |    |           \o       |    |
--                     |    |           ( \      |    |
--                     |    |                    |    |
--                     |    |                    |    |
--                     |    |                    |    |
--                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

local m = {}

--- debounces a function on the trailing edge.
--
-- creates  a debounced  function that  delays invoking
-- the  given function  until after  delay milliseconds
-- have  elapsed  since  the last  time  the  debounced
-- function was  invoked. the  debounce happens  on the
-- trailing edge of the delay  by default; no option is
-- provided to  change this  behaviour since it  is the
-- most frequently used and  to keep everything simple.
-- the  function is  invoked  with  the last  arguments
-- provided to the debounced function. subsequent calls
-- to the  debounced function return the  result of the
-- last function invocation.
--
-- /s function.
--
-- @param delay (number)   → timeout in milliseconds.
-- @param f     (function) → function to debounce.
-- @returns     (function) → debounced function.

function m.debounce (delay, f)
   local timer = vim.loop.new_timer()

   return function (...)
      local args = { ... }

      timer:start(delay, 0, function ()
         timer:stop()
         f(unpack(args))
      end)
   end
end

--- throttles a function on the leading edge.
--
-- creates a  throttled function that only  invokes the
-- given  function  at  most   once  every  delay.  the
-- debounce happens on the leading edge of the delay by
-- default;  no  option  is  provided  to  change  this
-- behaviour since  it is the most  frequently used and
-- to keep everything simple. the generated function is
-- invoked  with the  last  arguments  provided to  the
-- throttled   function.   subsequent  calls   to   the
-- throttled  function return  the result  of the  last
-- generated function invocation.
--
-- @param delay (number)   → timeout in ms.
-- @param f     (function) → function to throttle.
-- @returns     (function) → throttled function.

function m.throttle (delay, f)
   local timer   = vim.loop.new_timer()
   local running = false

   return function (...)
      if not running then
         timer:start(delay, 0, function ()
            running = false
            timer:stop()
         end)

         running = true
         f(...)
      end
   end
end

-------------------------------- module exports --------------------------------

-- the module is exported here.

return m
