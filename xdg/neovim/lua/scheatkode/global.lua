local api = vim.api
local fn  = vim.fn

local f = require('f')

------------------------------------------------------------------------------
-- global namespace
------------------------------------------------------------------------------

_G.__scheatkode_global_functions = __scheatkode_global_functions or {}

_G.scheatkode = {
   _store = __scheatkode_global_functions,
   -- TODO(scheatkode): refactor once neovim allows passing lua functions to
   -- mappings.
   mappings = {},
}

------------------------------------------------------------------------------
-- ui
------------------------------------------------------------------------------

-- consistent  store  for  various UI  items  to  reuse
-- throughout config.

scheatkode.style = {
   icons = {
        error = '✗',
      warning = '',
         info = '',
         hint = '',
   },

   lsp = {
               Text = '',
             Method = '',
           Function = '',
        Constructor = '',
              Field = 'ﰠ',
           Variable = '',
              Class = 'ﴯ',
          Interface = '',
             Module = '',
           Property = 'ﰠ',
               Unit = '塞',
              Value = '',
               Enum = '',
            Keyword = '',
            Snippet = '',
              Color = '',
               File = '',
          Reference = '',
             Folder = '',
         EnumMember = '',
           Constant = '',
             Struct = 'פּ',
              Event = '',
           Operator = '',
      TypeParameter = '',
   },

   palette = {
           pale_red = '#e06c75',
           dark_red = '#be5046',
          light_red = '#c43e1f',
        dark_orange = '#ff922b',
              green = '#98c379',
      bright_yellow = '#fab005',
       light_yellow = '#e5c07b',
          dark_blue = '#4e88ff',
            magenta = '#c678dd',
       comment_grey = '#5c6370',
               grey = '#3e4556',
         whitesmoke = '#626262',
        bright_blue = '#51afef',
               teal = '#15aabf',
   },
}

------------------------------------------------------------------------------
-- debugging
------------------------------------------------------------------------------

--- Inspect the contents of an object.
--- @vararg any
function scheatkode.dump(...)
   local objects = {}
   local    args = ...

   f.range(1, select('#', ...)):foreach(function(x)
      table.insert(objects, vim.inspect(select(x, args)))
   end)

   print(table.concat(objects, '\n'))
   return ...
end

--- TODO(scheatkode): documentation
--- @vararg ...
function _G.dump_text(...)
   local objects = {}
   local    args = ...

   f.range(1, select('#', ...)):foreach(function (x)
      table.insert(objects, vim.inspect(select(x, args)))
   end)

   local lines = vim.split(table.concat(objects, '\n'), '\n')
   local  lnum = api.nvim_win_getcursor(0)[1]

   fn.append(lnum, lines)

   return ...
end

--- cache installed  plugins to avoid  reiterating over
--- the list of plugins again.

local installed

--- Check if a  plugin is installed, not  whether it is
--- loaded.
---
--- @param name string
--- @return boolean
function scheatkode.plugin_installed(name)
   if not installed then
      local dirs = fn.expand(fn.stdpath('data') .. '/site/pack/packer/start/*', true, true)
      local  opt = fn.expand(fn.stdpath('data') .. '/site/pack/packer/opt/*',   true, true)

      vim.list_extend(dirs, opt)

      installed = f.iterate(dirs):map(function (path)
         return fn.fnamemodify(path, ':t')
      end)
   end

   return installed:any(function (x) return x == name end)
   -- return vim.tbl_contains(installed, plugin_name)
end

--- Returns  the currently  loaded  state  of a  plugin
--- given the  assumption that  the plugin is  not lazy
--- loaded.
--- @param name string
--- @return boolean?
function scheatkode.plugin_loaded(name)
   local plugins = packer_plugins or {}

   return plugins[name]
      and plugins[name].loaded
end

------------------------------------------------------------------------------
-- utils
------------------------------------------------------------------------------

--- Verify if a given command is executable.
--- @param command string
--- @return boolean
function scheatkode.executable(command)
   return fn.executable(command) > 0
end

--- A terser proxy for `nvim_replace_termcodes`
--- @param code string
--- @return any
function scheatkode.replace_termcodes(code)
  return api.nvim_replace_termcodes(code, true, true, true)
end

--- Verify if a directory exists using vim's `isdirectory`.
--- @see :h isdirectory
--- @param path string
--- @return boolean
function scheatkode.is_directory(path)
   return fn.isdirectory(path) > 0
end

--- Verify if a mapping already exists.
--- @param lhs string
--- @param mode string
--- @return boolean
function scheatkode.has_mapping(lhs, mode)
   return fn.maparg(lhs, mode or 'n') ~= ''
end

--- TODO(scheatkode): Documentation
function scheatkode.invalidate(path, recursive)
   if not recursive then
      package.loaded[path] = nil
      require(path)
      return
   end

   f.iterate(package.loaded):foreach(function (k, v)
      if
             k ~= '_G'
         and v
         and fn.match(k, path) ~= -1
      then
         package.loaded[k] = nil
         require(k)
      end
   end)
end

--- Convert UTF-8 hex code to character.
--- @param code number|string
--- @return string
function scheatkode.u(code)
   if type(code) == 'string' then
      code = tonumber('0x' .. code)
   end

   local c = string.char

   if code <= 0x7f then
      return c(code)
   end

   local t = {}

   if code <= 0x07ff then
      t[1] = c(bit.bor(0xc0, bit.rshift(code, 6)))
      t[2] = c(bit.bor(0x80, bit.band(code, 0x3f)))
   elseif code <= 0xffff then
      t[1] = c(bit.bor(0xe0, bit.rshift(code, 12)))
      t[2] = c(bit.bor(0x80, bit.band(bit.rshift(code, 6), 0x3f)))
      t[3] = c(bit.bor(0x80, bit.band(code, 0x3f)))
   else
      t[1] = c(bit.bor(0xf0, bit.rshift(code, 18)))
      t[2] = c(bit.bor(0x80, bit.band(bit.rshift(code, 12), 0x3f)))
      t[3] = c(bit.bor(0x80, bit.band(bit.rshift(code,  6), 0x3f)))
      t[4] = c(bit.bor(0x80, bit.band(code, 0x3f)))
   end

   return table.concat(t)
end

-- vim: set fdm=marker fdl=0:
