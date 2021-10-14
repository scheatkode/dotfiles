local api = vim.api
local fn  = vim.fn
local lev = vim.log.levels

local format = string.format

local p = scheatkode.style.palette

local f = require('f')

local m = {}

--- Convert a hex color to rgb.
---
--- @param color string
--- @return number
--- @return number
--- @return number
local function hex_to_rgb(color)
   local hex = color:gsub('#', '')

   return
      tonumber(hex:sub(1, 2), 16),
      tonumber(hex:sub(3, 4), 16),
      tonumber(hex:sub(5),    16)
end

local function alter(attr, percent)
   return math.floor(attr * (100 + percent) / 100)
end

--- Darken a given hex color
--- @param color string
--- @param percent number
--- @return string
function m.darken(color, percent)
   local r, g, b = hex_to_rgb(color)

   if not r or not g or not b then
      return 'NONE'
   end

   r, g, b = alter(r, percent), alter(g, percent), alter(b, percent)
   r, g, b = math.min(r, 255), math.min(g, 255), math.min(b, 255)

   return format('#%02x%02x%02x', r, g, b)
end

--- Verify if the current window has a winhighlight which includes the
--- specific target highlight.
--- @param id number
--- @vararg string
function m.has_win_highlight(id, ...)
   local hl = vim.wo[id].winhighlight

   for _, target in ipairs({ ... }) do
      if hl:match(target) ~= nil then
         return true, hl
      end
   end

   return false, hl
end

--- A mechanism to allow inheritance of the winhighlight of a specific group
--- in a window.
--- @param id number
--- @param target string
--- @param name string
--- @param default string
function m.adopt_winhighlight(id, target, name, default)
   name = name .. id

   local _, hl  = m.has_win_highlight(id, target)
   local has_hl = fn.hlexists(name) > 0

   if not has_hl then
      local parts = vim.split(hl, ',')
      local found = f.iterate(parts):any(function (part) part:match(target) end)

      if found then
         local hl_group = vim.split(found, ':')[2]
         local bg  = m.get_hl(hl_group, 'bg')
         local fg  = m.get_hl(default,  'fg')
         local gui = m.get_hl(default,  'gui')

         m.set_hl(name, {
            guibg = bg,
            guifg = fg,
              gui = gui,
         })
      end
   end

   return name
end

--- NOTE: vim.highlight's link and create are, eventually move to using
--- `nvim_set_hl`.
--- @param name string
--- @param options table
function m.set_hl(name, options)
   assert(name and options, "Both 'name' and 'options' must be specified")

   if not vim.tbl_isempty(options) then
      if options.link then
         vim.highlight.link(name, options.link, options.force)
      else
         local ok, message = pcall(vim.highlight.create, name, options)

         if not ok then
            vim.notify(format("Failed to set '%s' because: %s", name, message))
         end
      end
   end
end

--- Convert a table of gui values into a string
--- @param hl table<string, string>
--- @return string
local function flatten_gui(hl)
   local gui_attributes = { 'underline', 'bold', 'undercurl', 'italic' }
   local gui = {}

   f.iterate(hl):foreach(function (name, value)
      if value and vim.tbl_contains(gui_attributes, name) then
         table.insert(gui, name)
      end
   end)

   return table.concat(gui, ',')
end

--- Get the value of a highlight group.
--- This function is a small wrapper around `nvim_get_hl_by_name` which
--- handles errors, fallbacks, as well as returning a gui value in the right
--- format.
--- @param group string
--- @param attribute string
--- @param fallback string
--- @return string
function m.get_hl(group, attribute, fallback)
   if not group then
      vim.notify('Cannot get a highlight without specifying a group', lev.ERROR)
      return 'NONE'
   end

   local attributes = { fg = 'foreground', bg = 'background' }
   local hl = api.nvim_get_hl_by_name(group, true)

   attribute = attributes[attribute] or attribute

   if attribute == 'gui' then
      return flatten_gui(hl)
   end

   local color = hl[attribute] or fallback

   if not color then
      vim.notify(format('%s %s does not exist', group, attribute), lev.ERROR)
      return 'NONE'
   end

   -- convert the decimal rgba value from the hl by name to a 6 character hex
   -- + padding if needed.

   return '#' .. bit.tohex(color, 6)
end

function m.clear_hl(name)
   if not name then
      return
   end

   vim.cmd('highlight clear ' .. name)
end

--- Apply a list of highlights.
--- @param hls table[]
function m.all(hls)
   f.iterate(hls):foreach(function (hl) m.set_hl(unpack(hl)) end)
end

return m
