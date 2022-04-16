local sf   = string.format
local pipe = require('f.function.pipe')

local function setup ()
   -- show the cursorline only in the active window {{{1

   local cursor_line_augroup = vim.api.nvim_create_augroup('CursorLine', {clear = true})

   vim.api.nvim_create_autocmd({'BufEnter', 'WinEnter', 'BufWinEnter'}, {
      group    = cursor_line_augroup,
      callback = function ()
         if -- should we show the cursorline ?
            not vim.wo.previewwindow
            and vim.bo.buftype      ~= 'terminal'
            and vim.bo.filetype     ~= ''
            and vim.wo.winhighlight == ''
         then
            vim.wo.cursorline = true
         end
      end
   })

   vim.api.nvim_create_autocmd('WinLeave', {
      group    = cursor_line_augroup,
      callback = function () vim.wo.cursorline = false end
   })

   -- highlight yanked text {{{1
   vim.api.nvim_create_autocmd('TextYankPost', {
      group    = vim.api.nvim_create_augroup('HighlightYank', {clear = true}),
      callback = function ()
         vim.highlight.on_yank {
            timeout   = 100,
            on_visual = false,
         }
      end
   })

   -- quickfix auto open {{{1
   vim.api.nvim_create_autocmd('QuickFixCmdPost', {
      group   = vim.api.nvim_create_augroup('QuickFixAutoOpen', {clear = true}),
      command = 'cwindow'
   })

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
      if vim.fn.winnr('$') ~= 1 then
         vim.api.nvim_win_close(0, true)
      end
   end

   local smart_close_augroup = vim.api.nvim_create_augroup('SmartClose', {clear = true})

   vim.api.nvim_create_autocmd('FileType', {
      desc     = 'close certain filetypes by pressing `q`',
      group    = smart_close_augroup,
      callback = function ()
         local is_readonly = (
            not vim.bo.modifiable
            or  vim.bo.readonly
         ) and  vim.fn.hasmapto('q', 'n') == 0

         local is_eligible = vim.bo.buftype ~= ''
            or is_readonly
            or vim.wo.previewwindow
            or vim.tbl_contains(smart_close_filetypes, vim.bo.filetype)

         if is_eligible then
            vim.keymap.set('n', 'q', smart_close, {buffer = 0, nowait = true})
         end
      end
   })

   vim.api.nvim_create_autocmd('BufEnter', {
      desc     = 'close quickfix window if the file containing it was closed',
      group    = smart_close_augroup,
      callback = function ()
         if vim.fn.winnr('$') == 1 and vim.bo.buftype == 'quickfix' then
            vim.api.nvim_buf_delete(0, {force = true})
         end
      end
   })

   vim.api.nvim_create_autocmd('QuitPre', {
      desc     = 'automatically close corresponding loclist when quitting a window',
      group    = smart_close_augroup,
      nested   = true,
      callback = function ()
         if vim.bo.filetype ~= 'qf' then
            vim.cmd('silent! lclose')
         end
      end
   })

   vim.api.nvim_create_autocmd('WinEnter', {
      desc     = "don't wait when closing temporary buffers such as `lsp_hover`",
      group    = smart_close_augroup,
      callback = function ()
         local is_eligible = vim.bo.buftype == 'nofile'
                        and vim.bo.filetype == ''

         if is_eligible then
            vim.keymap.set('n', 'q', smart_close, {buffer = 0, nowait = true})
         end
      end
   })

   -- clear command line after delay {{{1

   vim.api.nvim_create_autocmd({'CmdlineChanged', 'CmdlineLeave'}, {
      desc     = 'automatically clear the command line after a delay of a few seconds',
      group    = vim.api.nvim_create_augroup('ClearCommandMessages', {clear = true}),
      pattern  = ':',
      callback = (function ()
         -- track the timer object and stop any previous timers
         -- before setting a new one so that each change waits
         -- for 10 seconds and that 10 seconds is deferred each
         -- time.
         local timer

         return function ()
            if timer then
               timer:stop()
            end

            timer = vim.defer_fn(function ()
               if vim.fn.mode() == 'n' then
                  vim.cmd([[echon '']])
               end
            end, 10000)
         end
      end)()
   })

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
         or vim.fn.win_gettype() == 'popup'
   end

   --- Block list certain plugins and buffer types.
   --- @return boolean
   local function number_is_blocked()
      local window_type = vim.fn.win_gettype()

      if
             not vim.api.nvim_buf_is_valid(0)
         and not vim.api.nvim_buf_is_loaded(0)
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

   local toggle_line_numbers_augroup = vim.api.nvim_create_augroup('ToggleLineNumbers', {clear = true})

   vim.api.nvim_create_autocmd({
      'BufEnter',
      'WinEnter',
      'FileType',
      'FocusGained',
      'InsertLeave'
   }, {
      group    = toggle_line_numbers_augroup,
      callback = enable_relative_number,
   })

   vim.api.nvim_create_autocmd({
      'BufEnter',
      'WinEnter',
      'FileType',
      'FocusGained',
      'InsertLeave'
   }, {
      group    = toggle_line_numbers_augroup,
      callback = disable_relative_number,
   })

   -- lazy load builtin plugin {{{1

   -- automatically load builtin plugin
   -- @return function
   local function enable_plugin(plugin_name)
      return function ()
         local global_key = sf('loaded_%s', plugin_name)

         if vim.g[global_key] == nil or vim.g[global_key] == 2 then
            vim.g[global_key] = nil
            vim.cmd(sf('packadd %s', plugin_name))
         end
      end
   end

   vim.api.nvim_create_autocmd({'BufReadPre', 'FileReadPre'}, {
      desc     = 'Lazy load builtin plugins',
      group    = vim.api.nvim_create_augroup('ClearCommandMessages', {clear = true}),
      pattern  = {'*.lua', '*.html', '*.md', '*.tsx'},
      callback = enable_plugin('matchit')
   })

   -- prevent large files from causing too much noticeable overhead {{{1

   local function handle_large_file ()
      local threshold = 10485760 -- 10 MiB

      local backup
      local complete
      local eventignore
      local writebackup
      local undolevels

      return function ()
         local size = pipe(
            '<afile>',
            vim.fn.expand,
            vim.fn.getfsize
         )

         if size < threshold then return end

         backup      = vim.opt.backup:get()
         complete    = vim.opt.complete:get()
         eventignore = vim.opt.eventignore:get()
         undolevels  = vim.opt.undolevels:get()
         writebackup = vim.opt.writebackup:get()

         vim.opt.complete:remove('wbuU')
         vim.opt.backup      = false
         vim.opt.eventignore = 'FileType'
         vim.opt.undolevels  = -1
         vim.opt.writebackup = false

         vim.bo.bufhidden  = 'unload'
         vim.bo.swapfile   = false
         vim.wo.foldenable = false
         vim.wo.foldmethod = 'manual'
         vim.wo.wrap       = false

         print('Large file detected, disabling features to prevent slowdowns')

         local largefile_cleanup_augroup = vim.api.nvim_create_augroup('LargeFileCleanup', {clear = true})

         vim.api.nvim_create_autocmd('BufEnter', {
            group    = largefile_cleanup_augroup,
            buffer   = 0,
            callback = function ()
               vim.opt.complete:remove('wbuU')
               vim.opt.eventignore = 'FileType'
               vim.opt.backup      = false
               vim.opt.undolevels  = -1
               vim.opt.writebackup = false
            end
         })

         vim.api.nvim_create_autocmd('BufLeave', {
            group    = largefile_cleanup_augroup,
            buffer   = 0,
            callback = function ()
               vim.opt.backup      = backup
               vim.opt.complete    = complete
               vim.opt.eventignore = eventignore
               vim.opt.undolevels  = undolevels
               vim.opt.writebackup = writebackup
            end
         })
      end
   end

   vim.api.nvim_create_autocmd('BufReadPre', {
      desc     = 'prevent large files from causing too much overhead',
      group    = vim.api.nvim_create_augroup('LargeFile', {clear = true}),
      callback = handle_large_file(),
   })
end

return {
   setup = setup
}

-- vim: set fdm=marker fdl=0:

