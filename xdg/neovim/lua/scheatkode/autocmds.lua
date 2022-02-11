local fn  = vim.fn
local api = vim.api

local contains = vim.tbl_contains

-- ensure all autocommands are cleared {{{1

api.nvim_exec([[
   augroup vimrc
   autocmd!
   augroup END
]], false)


-- show the cursorline only in the active window {{{1

local function should_show_cursorline()
   return
              vim.bo.buftype ~= 'terminal'
      and not vim.wo.previewwindow
      and     vim.wo.winhighlight == ''
      and     vim.bo.filetype ~= ''
end

scheatkode.augroup('CursorLine', {{
   events = {
      'BufEnter',
      'WinEnter',
      'BufWinEnter',
   },

   targets = {
      '*',
   },

   command = function ()
      if should_show_cursorline() then
         vim.wo.cursorline = true
      end
   end,
},{
   events = {
      'WinLeave',
   },

   targets = {
      '*',
   },

   command = function ()
      vim.wo.cursorline = false
   end,
}})

-- highlight yanked text {{{1

scheatkode.augroup('HighlightYank', {{
   events = {
      'TextYankPost',
   },

   targets = {
      '*',
   },

   command = function ()
      vim.highlight.on_yank {
           timeout = 100,
         on_visual = false,
          hi_group = 'Visual',
      }
   end,
}})

-- quickfix auto open {{{1

scheatkode.augroup('QuickFixAutoOpen', {{
   events = {
      'QuickFixCmdPost',
   },

   targets = {
      '*grep*',
   },

   command = 'cwindow',
}})

-- smart close certain filetypes {{{1

local smart_close_filetypes = {
   '',
   'help',
   'git-status',
   'git-log',
   'gitcommit',
   'dbui',
   'LuaTree',
   'log',
   'Outline',
   'tsplayground',
   'qf',
}

local function smart_close()
   if fn.winnr('$') ~= 1 then
      api.nvim_win_close(0, true)
   end
end

scheatkode.augroup('SmartClose', {{
   -- close certain filetypes by pressing `q`.

   events = {
      'FileType',
   },

   targets = {
      '*',
   },

   command = function ()
      local is_readonly = (
                vim.bo.readonly
         or not vim.bo.modifiable
      ) and fn.hasmapto('q', 'n') == 0

      local is_eligible = vim.bo.buftype ~= ''
         or is_readonly
         or vim.wo.previewwindow
         or contains(smart_close_filetypes, vim.bo.filetype)

      if is_eligible then
         scheatkode.nnoremap('q', smart_close, { buffer = 0, nowait = true })
      end
   end,
}, {
   -- close quickfix window if the file containing it was closed.

   events = {
      'BufEnter',
   },

   targets = {
      '*'
   },

   command = function ()
      if fn.winnr('$') == 1 and vim.bo.buftype == 'quickfix' then
         api.nvim_buf_delete(0, { force = true })
      end
   end,
}, {
   -- automatically close corresponding loclist when quitting a window.

   events = {
      'QuitPre',
   },

   targets = {
      '*',
   },

   modifiers = {
      'nested',
   },

   command = function ()
      if vim.bo.filetype ~= 'qf' then
         vim.cmd('silent! lclose')
      end
   end,
},{
   -- don't wait when closing temporary buffers, such as `lsp_hover`.

   events = {
      'WinEnter'
   },

   targets = {
      '*',
   },

   command = function ()
      local is_eligible = vim.bo.buftype == 'nofile'
                      and vim.bo.filetype == ''

      if is_eligible then
         scheatkode.nnoremap('q', smart_close, { buffer = 0, nowait = true })
      end
   end,

}})

-- clear command line after delay {{{1

-- automatically clear the command line after a delay of a few seconds.
-- @return function
local function clear_command_line()
   -- track the timer obejct and stop any previous timers before setting a new
   -- one so that each change waits for 10 seconds and that 10 seconds is
   -- deferred each time.
   local timer

   return function ()
      if timer then
         timer:stop()
      end

      timer = vim.defer_fn(function ()
         if fn.mode() == 'n' then
            vim.cmd([[echon '']])
         end
      end, 10000)
   end
end

scheatkode.augroup('ClearCommandMessages', {{
   events = {
      'CmdlineLeave',
      'CmdlineChanged',
   },

   targets = {
      ':',
   },

   command = clear_command_line(),
}})

-- exclude showing number column with certain filetypes {{{1

local number_filetype_exclusions = {
   'NvimTree',
   'Trouble',
   'dap-repl',
   'gitcommit',
   'help',
   'himalaya',
   'list',
   'log',
   'lsputil_locations_list',
   'lsputil_symbols_list',
   'man',
   'markdown',
   'org',
   'orgagenda',
   'startify',
   'toggleterm',
   'undotree',
}

local number_buftype_exclusions = {
   'terminal',
   'help',
   'nofile',
   'acwrite',
   'quickfix',
}

local number_buftype_ignored = {
   'quickfix',
}

--- Determines whether a window should be ignored.
--- @return boolean
local function number_is_ignored()
   return
         vim.tbl_contains(number_buftype_ignored, vim.bo.buftype)
      or scheatkode.is_floating_window()
end

--- Block list certain plugins and buffer types.
--- @return boolean
local function number_is_blocked()
   local window_type = fn.win_gettype()

   if
          not api.nvim_buf_is_valid(0)
      and not api.nvim_buf_is_loaded(0)
   then
      return true
   end

   if vim.wo.diff then
      return true
   end

   if window_type == 'command' then
      return true
   end

   if vim.wo.previewwindow then
      return true
   end

   for _, filetype in ipairs(number_filetype_exclusions) do
      if vim.bo.ft == filetype or string.match(vim.bo.ft, filetype) then
         return true
      end
   end

   if vim.tbl_contains(number_buftype_exclusions, vim.bo.buftype) then
      return true
   end

   return false
end

local function enable_relative_number()
   if number_is_ignored() then
      return
   end

   if number_is_blocked() then
      vim.wo.number         = false
      vim.wo.relativenumber = false

      return
   end

   vim.wo.number         = true
   vim.wo.relativenumber = true
end

local function disable_relative_number()
   if number_is_ignored() then
      return
   end

   if number_is_blocked() then
      vim.wo.number         = false
      vim.wo.relativenumber = false

      return
   end

   vim.wo.number         = true
   vim.wo.relativenumber = false
end

scheatkode.augroup('ToggleRelativeLineNumbers', {{
   events = {
      'BufEnter',
      'WinEnter',
      'BufEnter',
      'FileType',
      'FocusGained',
      'InsertLeave',
   },

   targets = {
      '*',
   },

   command = enable_relative_number,
}, {
   events = {
      'FocusLost',
      'BufLeave',
      'WinLeave',
      'InsertEnter',
      'TermOpen',
   },

   targets = {
      '*',
   },

   command = disable_relative_number,
}})

-- vim: set fdm=marker fdl=0:

-- lazy load builtin plugin {{{1

-- automatically load builtin plugin
-- @return function
local function enable_plugin(plugin_name)
   return function ()
      local global_key = 'loaded_' .. plugin_name

      if vim.g[global_key] == nil or vim.g[global_key] == 2 then
         vim.g[global_key] = nil
         vim.cmd('packadd ' .. plugin_name)
      end
   end
end

scheatkode.augroup('LoadMatchitBuiltinPlugin', {{
   events = {
      'BufReadPre',
      'FileReadPre',
   },

   targets = {
      '*.lua',
      '*.html',
      '*.tsx',
   },

   command = enable_plugin('matchit'),
}})

