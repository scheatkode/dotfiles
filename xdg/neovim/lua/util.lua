local api = vim.api
local compat = require('compat')
local table = require('sol.table')

local defaults = {
   silent  = true,
   noremap = true,
}

local callbacks = _G.callbacks or {}

local m = {}

--[[
   Call a function by its stored identifier.

   @param  id number → function identifier.
   @throws when the function is not found.
   @return the function's return value, if found.
-- ]]
m.call = function (id)
   local f = callbacks[id]

   if not f then
      error(('Function %s does not exist.'):format(id))
   end

   return f()
end


--[[
   Escape a given string with terminal codes.

   @param [string] s → the string to escape.

   @return the string escaped.
--]]
m.escape_termcodes = function (s)
   return api.nvim_replace_termcodes(s, true, true, true)
end


--[[
   Register a lua function as callable from a key binding

   This registers a given function in a global table to be called directly
   from a key binding.

   @param {function} f      → function to register
   @param {boolean} is_expr → whether the function is to be called inside an
                              expression
--]]
local register_function_command = function (f, is_expr)
   if type(f) == 'function' then
      table.insert(callbacks, f)

      if is_expr then
         f = ([[luaeval('require("util").call(%d)')]]):format(#callbacks)
      else
         f = ([[<cmd>lua require('util').call(%d)<CR>]]):format(#callbacks)
      end
   end

   return f
end


--[[
   Register a single keymap for neovim

   Given a table containing a key binding description, this function parses
   the keymap and registers it for use with neovim.

   @param {table} mapping → key binding to register
--]]
m.register_single_keymap = function (mapping)
   local mode        = mapping.mode        or 'n'
   local keys        = mapping.keys        or error('No key combination given')
   local command     = mapping.command     or error('No command given' .. scheatkode.dump(mapping))
   local options     = mapping.options     or {}
   local buffer      = options.buffer

   options = vim.tbl_deep_extend('force', {}, defaults, options)
   command = register_function_command(command, options.expr or false)

   if buffer ~= nil then
      options.buffer = nil

      return api.nvim_buf_set_keymap(buffer, mode, keys, command, options)
   end

   return api.nvim_set_keymap(mode, keys, command, options)
end


--[[
   Register keymaps for Neovim.

   Given a table of formatted key mappings, this function iterates and
   registers the keymaps for use with Neovim.

   @param {table} mappings → key mappings to register
--]]
m.register_keymaps = function (mappings)
   for _, v in ipairs(mappings) do
      m.register_single_keymap(v)
   end
end


--[[
   Register variables for Neovim.

   Given a table of key/values, this function iterates and registers
   the given variables for use with Neovim.

   @param scope     string: scope of variables to register
   @param variables table:  variables to register

   @return nil
--]]
m.register_variables = function (scope, variables)
   local scopes = { 'g', 'b', 'w', 't', 'v' }

   if table.contains(scopes, scope) then
      error('Given scope "' .. scope .. '" is invalid.')
   end

   for k, v in pairs(variables) do
      vim[scope][k] = v
   end
end


-- [[
-- ]]
m.eat_char = function (pattern)
   local character = vim.fn.nr2char(vim.fn.getchar(0))

   if vim.regex(pattern):match_str(character) then
      return character
   end

   return ''
end


---converts path parts to a string.
---@param parts table parts to merge
---@return string path merged path
m.parts_to_path = function (parts)
	return table.concat(parts, compat.path_separator)
end


---create a table from multiple parts.
---@vararg ...
---@return table
m.parts_to_table = function (...) return { ... } end

_G.callbacks = callbacks
return m
