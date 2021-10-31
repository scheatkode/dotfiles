--- @brief [[
---
--- Lua 5.1/5.2/5.3 compatibility.
---
--- This  does  not  inject anything  into  the  global
--- environment, the  user is  free to  do so  at their
--- convenience.
---
--- @brief ]]

--- @diagnostic disable: deprecated


--- @class compat
local compat = {}


--- Boolean flag for Lua 5.1 or LuaJit.
compat.lua51 = _VERSION == 'Lua 5.1'


--- Boolean flag for LuaJit.
compat.luajit = type(jit) == 'table'


--- Boolean flag for Neovim.
compat.neovim = type(vim) == 'table'

--- Boolean flag for LuaJit  with Lua 5.2 compatibility
--- compiled in. Detection happens with `goto` since it
--- is considered  a keyword when 5.2  compatibility is
--- enabled in LuaJit.
if compat.luajit then
   compat.luajit52 = not loadstring('local goto = 1')
end


--- The directory  separator character for  the current
--- platform.
compat.path_separator = _G.package.config:sub(1,1)


--- Boolean flag for Windows detection.
compat.is_windows = compat.path_separator == '\\'


--- Execute  a  shell  command   in  a  compatible  and
--- platform independent  way. This is  a compatibility
--- function that returns the same  for Lua 5.1 and Lua
--- 5.2+.
---
--- NOTE: Windows systems can use signed 32 bit integer
---       exit codes. Posix systems only use exit codes
---       in  the  [0..255]  range,  anything  else  is
---       considered undefined.
---
--- NOTE: In  Lua5.2 and  5.3, a  Windows exit  code of
---       `-1`  would not  be  properly returned,  this
---       function  will  handle  it properly  for  all
---       versions.
---
--- @param command string a shell command
--- @return boolean true if successful
--- @return number actual return code
function compat.execute (command)
   local r1, r2, r3 = os.execute(command)

   if r2 == 'No error' and r3 == 0 and compat.is_windows then

      --- `os.execute` bug in Lua 5.2/5.3 not reporting `-1` properly on
      --- Windows was fixed in 5.4.

      r3 = -1
   end

   if compat.lua51 and not compat.luajit52 then
      if compat.is_windows then
         return r1 == 0, r1
      end

      r1 = r1 > 255 and r1 / 256 or r1
      return r1 == 0, r1
   end

   if compat.is_windows then
      return r3 == 0, r3
   end

   return not not r1, r3
end


if compat.lua51 then --- define lua 5.2 style `load()`
   --- Get environment of a function (Lua 5.1 compat).
   ---
   --- NOTE: Not 100% compatible, it  may return nil for a
   ---       function  with no  global  references on  Lua
   ---       5.2.
   ---
   --- @param f function a function or a call stack reference.
   --- @function compat.getfenv
   compat.getfenv = getfenv

   --- Set environment of a function (Lua 5.1 compat).
   ---
   --- @param f function a function or a call stack reference.
   --- @param env table a table that becomes the new environment for `f`.
   --- @function compat.getfenv
   compat.setfenv = setfenv

   if not compat.luajit then --- but luajit's load *is* compatible.
      local lua51_load = load

      --- Load Lua  code as a  text or binary chunk  (Lua 5.2
      --- compat).
      ---
      --- @param str string|function code string or loader.
      --- @param source? string name of chunk for errors.
      --- @param mode? 'b' | 't' | 'bt'
      --- @param env? table environment to load the chunk in.
      function compat.load (str, source, mode, env)
         local chunk, err

         if type(str) == 'string' then
            if str:byte(1) == 27 and not (mode or 'bt'):find('b') then
               return nil, 'attempt to load a binary chunk'
            end

            chunk, err = loadstring(str, source)
         else
            chunk, err = lua51_load(str, source)
         end

         if chunk and env then
            compat.setfenv(chunk, env)
         end

         return chunk, err
      end
   else
      --- Load Lua  code as a  text or binary chunk  (Lua 5.2
      --- compat).
      ---
      --- @param str string|function code string or loader.
      --- @param source? string name of chunk for errors.
      --- @param mode? 'b' | 't' | 'bt'
      --- @param env? table environment to load the chunk in.
      compat.load = load
   end
else
   --- Load Lua  code as a  text or binary chunk  (Lua 5.2
   --- compat).
   ---
   --- @param str string|function code string or loader.
   --- @param source? string name of chunk for errors.
   --- @param mode? 'b' | 't' | 'bt'
   --- @param env? table environment to load the chunk in.
   compat.load = load

   --- `setfenv`/`getfenv` replacements for Lua 5.2.

   --- Set environment of a function (Lua 5.1 compat).
   ---
   --- @param f function a function or a call stack reference.
   --- @param t table a table that becomes the new environment for `f`.
   --- @function compat.getfenv
   function compat.setfenv(f, t)
      local name
      local up = 0

      f = (type(f) == 'function' and f or debug.getinfo(f + 1, 'f').func)

      repeat
         up   = up + 1
         name = debug.getupvalue(f, up)
      until name == '_ENV' or name == nil

      if name then
         debug.upvaluejoin(f, up, function () return name end, 1)
         debug.setupvalue(f, up, t)
      end

      if f ~= 0 then return f end
   end

   --- Get environment of a function (Lua 5.1 compat).
   ---
   --- NOTE: Not 100% compatible, it  may return nil for a
   ---       function  with no  global  references on  Lua
   ---       5.2.
   ---
   --- @param f function a function or a call stack reference.
   --- @function compat.getfenv
   function compat.getfenv(f)
      local name, value
      local up = 0

      f = f or 0
      f = (type(f) == 'function' and f or debug.getinfo(f + 1, 'f').func)

      repeat
         up = up + 1
         name, value = debug.getupvalue(f, up)
      until name == '_ENV' or name == nil

      return value
   end
end


--- Global exported functions (for Lua 5.1 and LuaJit) {{{1


--- Pack an argument list into a table.
---
--- @vararg ... any
--- @return table a table with field `n` set to the length
if not table.pack then
   function compat.table_pack (...)
      return { n = select('#', ...); ... }
   end
else
   compat.table_pack = table.pack
end


local _unpack = table.unpack or unpack
--- Unpack a table and return the elements.
---
--- NOTE:  This  implementation  differs from  the  Lua
---       implementation  in  the  way  that  this  one
---       honors the  `n` field in the  table `t`, such
---       that it is *nil-safe*.
---
--- @param t table table to unpack
--- @param i? number index from which to start unpacking, defaults to 1
--- @param j? number index of the last element to unpack, defaults to `#t`
--- @return any multiple return values from the table
function compat.table_unpack (t, i, j)
   return _unpack(t, i or 1, j or t.n or #t)
end


if not package.searchpath then
   --- Get the full  path where a file  name would have
   --- matched.  This function  was  introduced in  Lua
   --- 5.2. This compatibility version will be injected
   --- in Lua 5.1 engines.
   ---
   --- @param name string file name, possibly dotted
   --- @param path string a path-template in the same form as `package.path` or `package.cpath`
   --- @param sep? string template separate character to be replaced by path separator. Default: '.'
   --- @param separator? string path separator to use, defaults to system separator
   --- @return string path of the file on success
   --- @return nil, string on failure, the error string lists the paths tried
   function compat.package_searchpath (name, path, sep, separator)
      assert(type(name) == 'string', ('bad argument #1 to \'searchpath\' (string expected, got %s)'):format(type(path), 2))
      assert(type(path) == 'string', ('bad argument #2 to \'searchpath\' (string expected, got %s)'):format(type(path), 2))
      assert(sep       == nil or type(sep)       == 'string', ('bad argument #3 to \'searchpath\' (string expected, got %s)'):format(type(path), 2))
      assert(separator == nil or type(separator) == 'string', ('bad argument #4 to \'searchpath\' (string expected, got %s)'):format(type(path), 2))

      sep       = sep or '.'
      separator = separator or compat.path_separator

      do
         local s, e = name:find(sep, nil, true)

         while s do
            name = name:sub(1, s - 1)
               .. separator
               .. name:sub(e + 1, -1)

            s, e = name:find(
               sep,
               s + #separator + 1,
               true
            )
         end
      end

      local paths_tried = {}

      for m in path:gmatch('[^;]+') do
         local nm = m:gsub('?', name)
         local f  = io.open(nm, 'r')

         paths_tried[#paths_tried + 1] = nm

         if f then
            f:close()
            return nm
         end
      end

      return nil,
         '\n\tno file \''
         .. table.concat(paths_tried, '\'\n\tno file \'')
         .. '\''
   end

else
   --- Get the full  path where a file  name would have
   --- matched.  This function  was  introduced in  Lua
   --- 5.2. This compatibility version will be injected
   --- in Lua 5.1 engines.
   ---
   --- @param name string file name, possibly dotted
   --- @param path string a path-template in the same form as `package.path` or `package.cpath`
   --- @param sep? string template separate character to be replaced by path separator. Default: '.'
   --- @param separator? string path separator to use, defaults to system separator
   --- @return string path of the file on success
   --- @return nil, string on failure, the error string lists the paths tried
   compat.package_searchpath = package.searchpath
end


--- Global exported functions (for Lua < 5.4) {{{1

if not warn then
   local enabled = false

   --- Raise a warning message.
   --- This function  mimics the `warn`  function added
   --- in Lua 5.4.
   ---
   --- @vararg ... any
   function compat.warn (arg1, ...)
      if type(arg1) == 'string' and arg1:sub(1, 1) == '@' then
         --- control message
         if arg1 == '@on' then
            enabled = true
            return
         end

         if arg1 == '@off' then
            enabled = false
            return
         end

         --- ignore unknown control messages
         return
      end

      if enabled then
         io.stderr:write('Lua warning: ', arg1, ...)
         io.stderr:write('\n')
      end
   end
else
   --- Raise a warning message.
   --- This function  mimics the `warn`  function added
   --- in Lua 5.4.
   ---
   --- @vararg ... any
   compat.warn = warn
end

return compat

--- vim: set fdm=marker fdl=0:

