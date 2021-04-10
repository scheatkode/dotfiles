-- check if galaxyline is installed first.

local ok, galaxyline = pcall(require, 'galaxyline')

-- if not, inform the user and softly return to the calling file.

if not ok then
   print('‼ Tried importing galaxyline plugin ... unsuccessfully.')
   return ok
end

-- galaxyline specific imports.

local condition  = require('galaxyline.condition')
local diagnostic = require('galaxyline.provider_diagnostic')
local fileinfo   = require('galaxyline.provider_fileinfo')
local vcs        = require('galaxyline.provider_vcs')

-- coloring and the such.

local colors    = require('colors.gruvbox')
local glyph     = require('icons.glyph')
local powerline = require('icons.powerline')

-- galaxyline ignore.

galaxyline.short_line_list = {
   'NvimTree',
   'dbui',
   'packer',
}

galaxyline.section.left = {{
   left_rounded = {
       provider = function() return powerline.crescent_left_full end,
      highlight = { colors.bg1 }
   }}, {

   vi_mode = {
      provider = function ()
         -- auto change color according to vim mode.
         local mode_color = {
                 n = colors.red,
                 i = colors.green,
                 v = colors.blue,
            [''] = colors.blue,
                 V = colors.blue,
                 c = colors.lightred,
                no = colors.red,
                 s = colors.orange,
                 S = colors.orange,
            [''] = colors.orange,
                ic = colors.yellow,
                 R = colors.lightpurple,
                Rv = colors.lightpurple,
                cv = colors.red,
                ce = colors.red,
                 r = colors.aqua,
                rm = colors.aqua,
            ['r?'] = colors.aqua,
             ['!'] = colors.red,
                 t = colors.red
         }

         vim.api.nvim_command(
            'highlight Galaxyvi_mode guifg=' .. mode_color[vim.fn.mode()]
         )

         return glyph.large_circle
      end,

                highlight = { colors.red, colors.bg1, 'bold' },
                separator = ' ',
      separator_highlight = { colors.none, colors.bg1 },
   }}, {

      file_icon = {
          provider = fileinfo.get_file_icon,
         condition = condition.buffer_not_empty,
         highlight = {
            require('galaxyline.provider_fileinfo').get_file_icon_color,
            colors.bg1
         },
   }}, {

   file_name = {
       provider = { fileinfo.get_current_file_name, fileinfo.get_file_size },
      condition = condition.buffer_not_empty,
      highlight = { colors.fg1, colors.bg1, 'bold' },
   }}, {

   right_rounded = {
       provider = function () return powerline.crescent_right_full end,
      separator = ' ',
      highlight = { colors.bg1 },
   }}, {

   diagnostic_error = {
       provider = diagnostic.get_diagnostic_error,
           icon = ' ' .. glyph.large_circle .. ' ',
      highlight = { colors.red },
   }}, {

   diagnostic_warn = {
       provider = diagnostic.get_diagnostic_warn,
           icon = ' ' .. glyph.large_circle .. ' ',
      highlight = { colors.yellow },
   }}, {

   diagnostic_hint = {
       provider = diagnostic.get_diagnostic_hint,
           icon = ' ' .. glyph.large_circle .. ' ',
      highlight = { colors.aqua },
   }}, {

   diagnostic_info = {
       provider = diagnostic.get_diagnostic_info,
           icon = ' ' .. glyph.large_circle .. ' ',
      highlight = { colors.blue },
   }},
}

galaxyline.section.right = {{
   diff_add = {
       provider = vcs.diff_add,
      condition = condition.hide_in_width,
      highlight = { colors.green },
           icon = glyph.plus_square_full .. ' ',
   }}, {

   diff_remove = {
       provider = vcs.diff_remove,
      condition = condition.hide_in_width,
           icon = glyph.minus_square_full .. ' ',
      highlight = { colors.lightred },
   }}, {

   diff_modified = {
       provider = vcs.diff_modified,
      condition = condition.hide_in_width,
           icon = glyph.flickr .. ' ',
      highlight = { colors.orange },

      -- the  usual modified  icon (uf9c9)  causes some
      -- issues with  some fonts  on the  terminal, the
      -- flickr logo gets the  job done instead without
      -- being  a  pain  in  the ass  and  while  still
      -- getting the idea across.

   }}, {

   git_icon = {
       provider = function() return powerline.git_branch end,
      condition = condition.check_git_workspace,
      separator = ' ',
      highlight = { colors.lightpurple, 'bold' },
   }}, {

   git_branch = {
       provider = vcs.get_git_branch,
      condition = condition.check_git_workspace,
      separator = ' ',
      highlight = { colors.lightpurple, 'bold' },
   }}, {

   right_left_rounded = {
       provider = function () return powerline.crescent_left_full end,
      highlight = { colors.fg0 },
      separator = ' ',
   }}, {

   line_info = {
                 provider = fileinfo.line_column,
                separator = ' ',
                highlight = { colors.bg1,  colors.fg0 },
      separator_highlight = { colors.none, colors.fg0 },
   }}, {

   line_percent = {
                 provider = fileinfo.current_line_percent,
                separator = ' ',
                highlight = { colors.bg1,  colors.fg0, 'bold' },
      separator_highlight = { colors.none, colors.fg0 },
   }}, {

   right_right_rounded = {
       provider = function() return powerline.crescent_right_full end,
      highlight = { colors.fg0 },
   }},
}

galaxyline.section.short_line_left = {{
   shortened_path = {
       provider = function ()
         return vim.fn.pathshorten(vim.fn.expand('%:F'))
      end,
      condition = condition.buffer_not_empty,
      highlight = { colors.fg, 'bold' }
   }
}}

galaxyline.section.short_line_right = {{
   git_branch = {
       provider = vcs.get_git_branch,
      condition = condition.check_git_workspace,
      highlight = { colors.lightpurple, 'bold' },
   }}, {

   git_icon = {
       provider = function() return powerline.git_branch end,
      condition = condition.check_git_workspace,
      separator = ' ',
      highlight = { colors.lightpurple, 'bold' },
   }}, {

   buffer_icon = {
       provider = fileinfo.get_file_icon,
      separator = ' ',
      highlight = {
         require('galaxyline.provider_fileinfo').get_file_icon_color,
      },
   }}
}

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set sw=3 ts=3 sts=3 et tw=80 fmr={{{,}}} fdl=0 fdm=marker:
