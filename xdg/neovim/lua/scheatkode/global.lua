local format = string.format

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

--- Register the given function  `func` into the global
--- callback  table  for  later  use  and  returns  its
--- identifier.
--- @param func function
--- @return number
function scheatkode.register(func)
   assert(type(func) == 'function', 'The given `func` is not a function')

   table.insert(scheatkode._store, func)
   return #scheatkode._store
end

--- Register the given function  `func` into the global
--- callback  table  for  later  use  in  mappings  and
--- returns   a  string   pluggable   in  the   mapping
--- definition.
--- @param func function
--- @param is_expr boolean
--- @return string
function scheatkode.register_funcmap(func, is_expr)
   assert(type(func) == 'function', 'The given `func` is not a function')

   if is_expr then
      return ([[luaeval('require("globals").call(%d)']]):format(scheatkode.register(func))
   end

   return ([[<cmd>lua require('globals').call(%d)<CR>]]):format(scheatkode.register(func))
end

--- Execute a previously registered function.
--- @param id number
--- @param args any
function scheatkode.execute(id, args)
   scheatkode._store[id](args)
end

------------------------------------------------------------------------------
-- utils
------------------------------------------------------------------------------

--- Source  a lua  or  vimscript file  relative to  the
--- neovim directory.
--- @param path string
--- @param prefix boolean?
function scheatkode.source(path, prefix)
   if not prefix then
      vim.cmd(format('source %s', path))
      return
   end

   vim.cmd(format('source %s/%s', vim.g.vim_dir, path))
end

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

--- Verify if  a certain  feature/version/commit exists
--- in neovim.
--- @param feature string
--- @return boolean
function scheatkode.has(feature)
   return fn.has(feature) > 0
end

--- Verify if a directory exists using vim's `isdirectory`.
--- @see :h isdirectory
--- @param path string
--- @return boolean
function scheatkode.is_directory(path)
   return fn.isdirectory(path) > 0
end

--- Verify if a given number is truthy.
--- @param value number
function scheatkode.is_truthy(value)
   assert(type(value) == 'number', 'Value should be a number but you passed ' .. value)

   return value > 0
end

--- Determine if a value of any type is empty.
--- @param item any
--- @return boolean
function scheatkode.is_empty(item)
   if not item then
      return true
   end

   local item_type = type(item)

   if item_type == 'string' then
      return item == ''
   elseif item_type == 'table' then
      return vim.tbl_isempty(item)
   end

   -- TODO(scheatkode): Finish other types
end

--- Verify if a mapping already exists.
--- @param lhs string
--- @param mode string
--- @return boolean
function scheatkode.has_mapping(lhs, mode)
   return fn.maparg(lhs, mode or 'n') ~= ''
end

--- Create a mapping function factory.
--- @param mode string
--- @param o table
--- @return fun(lhs: string, rhs: string, opts: table|nil)
local function make_mapper(mode, o)
   -- Copy the  opts table  as extends will  mutate the
   -- opts table passed in otherwise.
   local parent_options = vim.deepcopy(o)

   --- Create a mapping
   --- @param lhs string
   --- @param rhs string|function
   --- @param options table
   return function (lhs, rhs, options)
      assert(lhs ~= mode, '`lhs` should not be the same as mode for ' .. lhs)
      assert(type(rhs) == 'string' or type(rhs) == 'function', '`rhs` should be a function or string')

      local buffer = options.buffer

      options = options and vim.deepcopy(options) or {}
      options.buffer = nil

      if type(rhs) == 'function' then
         rhs = format('<cmd>lua scheatkode.execute(%s)<CR>', scheatkode.register(rhs))
      end

      if buffer and type(buffer) == 'number' then
         options = vim.tbl_extend('keep', options, parent_options)
         api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, options)

         return
      end

      api.nvim_set_keymap(mode, lhs, rhs, vim.tbl_extend('keep', options, parent_options))
   end
end

local default_map_options     = { noremap = false, silent = true }
local default_noremap_options = { noremap = true,  silent = true }

scheatkode.nmap = make_mapper('n', default_map_options)
scheatkode.imap = make_mapper('i', default_map_options)
scheatkode.smap = make_mapper('s', default_map_options)
scheatkode.xmap = make_mapper('x', default_map_options)
scheatkode.vmap = make_mapper('v', default_map_options)
scheatkode.tmap = make_mapper('t', default_map_options)
scheatkode.omap = make_mapper('o', default_map_options)
scheatkode.cmap = make_mapper('c', { noremap = false, silent = false })

scheatkode.nnoremap = make_mapper('n', default_noremap_options)
scheatkode.inoremap = make_mapper('i', default_noremap_options)
scheatkode.snoremap = make_mapper('s', default_noremap_options)
scheatkode.xnoremap = make_mapper('x', default_noremap_options)
scheatkode.vnoremap = make_mapper('v', default_noremap_options)
scheatkode.tnoremap = make_mapper('t', default_noremap_options)
scheatkode.onoremap = make_mapper('o', default_noremap_options)
scheatkode.cnoremap = make_mapper('c', { noremap = true, silent = false })

--- Create a neovim command.
--- @param arguments table
function scheatkode.command(arguments)
   local nargs = arguments.nargs or 0
   local name  = arguments[1]
   local rhs   = arguments[2]

   local types = (
          arguments.types
      and type(arguments.types) == 'table'
   )  and table.concat(arguments.types, ' ')
      or ''

   if type(rhs) == 'function' then
      rhs = format(
         'lua scheatkode.execute(%d%s)',
         scheatkode.register(rhs),
         nargs > 0 and ', <f-args>' or ''
      )
   end

   vim.cmd(format('command! -nargs=%s %s %s %s', nargs, types, name, rhs))
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

