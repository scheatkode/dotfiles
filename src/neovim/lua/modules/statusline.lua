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

-- not the most beatiful colorscheme, but it works.

local colors = {
   bg       = '#202328',
   lightbg  = "#3c4048",
   lightfg  = "#d8dee9",
   fg       = '#bbc2cf',
   yellow   = '#fabd2f',
   cyan     = '#008080',
   darkblue = '#081633',
   green    = '#98be65',
   orange   = '#FF8800',
   violet   = '#a9a1e1',
   magenta  = '#c678dd',
   blue     = '#51afef',
   red      = '#ec5f67',
   lightred = "#df8890",
   light    = '#d8dee9',
   dark     = '#282c34',
}

-- galaxyline ignore.

galaxyline.short_line_list = {
   'NvimTree',
   'dbui',
   'packer',
}

galaxyline.section.left = {{
   left_rounded = {
      provider  = function() return '' end,
      highlight = { colors.lightbg }
   }}, {

      vi_mode = {
      provider = function()
         -- auto change color according the vim mode
         local mode_color = {
                 n = colors.red,
                 i = colors.green,
                 v = colors.blue,
            [''] = colors.blue,
                 V = colors.blue,
                 c = colors.magenta,
                no = colors.red,
                 s = colors.orange,
                 S = colors.orange,
            [''] = colors.orange,
                ic = colors.yellow,
                 R = colors.violet,
                Rv = colors.violet,
                cv = colors.red,
                ce = colors.red,
                 r = colors.cyan,
                rm = colors.cyan,
            ['r?'] = colors.cyan,
             ['!'] = colors.red,
                 t = colors.red
         }

         vim.api.nvim_command(
            'hi GalaxyViMode guifg='
            .. mode_color[vim.fn.mode()]
         )

         return '⬤ '
      end,
      highlight = { colors.red, colors.lightbg, 'bold' },
   }}, {

      file_icon = {
      provider  = fileinfo.get_file_icon,
      condition = condition.buffer_not_empty,
      highlight = {
         require('galaxyline.provider_fileinfo').get_file_icon_color,
         colors.lightbg
      },
   }}, {

   file_name = {
      provider  = { fileinfo.get_current_file_name, fileinfo.get_file_size },
      condition = condition.buffer_not_empty,
      highlight = { colors.lightfg, colors.lightbg, 'bold' },
   }}, {

   right_rounded = {
      provider  = function () return '' end,
      highlight = { colors.lightbg },
      separator = ' ',
   }}, {

   diagnostic_error = {
      provider  = diagnostic.get_diagnostic_error,
      icon      = '⬤ ',
      highlight = { colors.red },
   }}, {

   diagnostic_warn = {
      provider  = diagnostic.get_diagnostic_warn,
      icon      = ' ⬤ ',
      highlight = { colors.yellow },
   }}, {

   diagnostic_hint = {
      provider  = diagnostic.get_diagnostic_hint,
      icon      = ' ⬤ ',
      highlight = { colors.cyan },
   }}, {

   diagnostic_info = {
      provider  = diagnostic.get_diagnostic_info,
      icon      = ' ⬤ ',
      highlight = { colors.blue },
   }},
}

galaxyline.section.right = {{
   diff_add = {
      provider  = vcs.diff_add,
      condition = condition.hide_in_width,
      highlight = { colors.green },
      icon      = ' ',
   }}, {

   diff_remove = {
      provider  = vcs.diff_remove,
      condition = condition.hide_in_width,
      highlight = { colors.red },
      icon      = ' ',
   }}, {

   diff_modified = {
      provider  = vcs.diff_modified,
      condition = condition.hide_in_width,
      highlight = { colors.orange },
      icon      = ' ',
   }}, {

   git_branch = {
      provider  = vcs.get_git_branch,
      condition = condition.check_git_workspace,
      highlight = { colors.violet, 'bold' },
   }}, {

   git_icon = {
      provider  = function() return '' end,
      condition = condition.check_git_workspace,
      highlight = { colors.violet, 'bold' },
      separator = ' ',
   }}, {

   right_left_rounded = {
      provider  = function () return '' end,
      highlight = { colors.light },
      separator = ' ',
   }}, {

   line_info = {
      provider            = fileinfo.line_column,
      highlight           = { colors.dark, colors.light },
      separator           = ' ',
      separator_highlight = { 'NONE', colors.light },
   }}, {

   line_percent = {
      provider            = fileinfo.current_line_percent,
      separator           = ' ',
      separator_highlight = { 'NONE', colors.light },
      highlight           = { colors.dark, colors.light, 'bold' },
   }}, {

   right_right_rounded = {
      provider  = function() return '' end,
      highlight = { colors.light },
   }},
}

galaxyline.section.short_line_left = {{
   shortened_path = {
      provider  = function ()
         return vim.fn.pathshorten(vim.fn.expand('%:F'))
      end,
      condition = condition.buffer_not_empty,
      highlight = { colors.fg, 'bold' }
   }
}}

galaxyline.section.short_line_right = {{
   git_branch = {
      provider  = vcs.get_git_branch,
      condition = condition.check_git_workspace,
      highlight = { colors.violet, 'bold' },
   }}, {

   git_icon = {
      provider  = function() return '' end,
      condition = condition.check_git_workspace,
      separator = ' ',
      highlight = { colors.violet, 'bold' },
   }}, {

   buffer_icon = {
      provider  = fileinfo.get_file_icon,
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
