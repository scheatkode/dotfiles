local library    = require('lib')
local gl         = require('galaxyline')
local condition  = require('galaxyline.condition')
local vcs        = require('galaxyline.provider_vcs')
local diagnostic = require('galaxyline.provider_diagnostic')

local fn  = vim.fn
local gls = gl.section

gl.short_line_list = {'NvimTree', 'vista', 'dbui', 'packer'}

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

gls.left[1] = {
   left_rounded = {
      provider  = function() return '' end,
      highlight = {colors.lightbg}
   },
}

gls.left[2] = {
   ViMode = {
      provider = function()
         -- auto change color according the vim mode
         local mode_color = {
            n      = colors.red,
            i      = colors.green,
            v      = colors.blue,
            [''] = colors.blue,
            V      = colors.blue,
            c      = colors.magenta,
            no     = colors.red,
            s      = colors.orange,
            S      = colors.orange,
            [''] = colors.orange,
            ic     = colors.yellow,
            R      = colors.violet,
            Rv     = colors.violet,
            cv     = colors.red,
            ce     = colors.red,
            r      = colors.cyan,
            rm     = colors.cyan,
            ['r?'] = colors.cyan,
            ['!']  = colors.red,
            t      = colors.red
         }
         vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim.fn.mode()])
         return '⬤ '
      end,
      highlight = {colors.red, colors.lightbg, 'bold'},
   },
}

gls.left[3] ={
   FileIcon = {
      provider  = 'FileIcon',
      condition = condition.buffer_not_empty,
      highlight = {
         require('galaxyline.provider_fileinfo').get_file_icon_color,
         colors.lightbg
      },
   },
}

gls.left[4] = {
   FileName = {
      provider  = {'FileName', 'FileSize'},
      condition = condition.buffer_not_empty,
      highlight = {colors.lightfg, colors.lightbg, 'bold'},

      -- separator           = ' ',
      -- separator_highlight = {'NONE', colors.lightbg},
   }
}

gls.left[5] = {
   right_rounded = {
      provider  = function () return '' end,
      highlight = {colors.lightbg},
      separator = ' ',
      -- separator_highlight = {colors.lightbg},
   }
}

gls.left[6] = {
   DiagnosticError = {
      provider  = 'DiagnosticError',
      icon      = '⬤ ',
      highlight = {colors.red},
      -- separator = ' ',
      -- separator_highlight = {'NONE', colors.bg},
   }
}

gls.left[7] = {
   DiagnosticWarn = {
      provider  = 'DiagnosticWarn',
      icon      = ' ⬤ ',
      highlight = {colors.yellow},
      -- separator = ' ',
      -- separator_highlight = {'NONE', colors.bg},
   }
}

gls.left[8] = {
   DiagnosticHint = {
      provider  = 'DiagnosticHint',
      icon      = ' ⬤ ',
      highlight = {colors.cyan},
      -- separator = ' ',
      -- separator_highlight = {'NONE'},
   }
}

gls.left[9] = {
   DiagnosticInfo = {
      provider  = 'DiagnosticInfo',
      icon      = ' ⬤ ',
      highlight = {colors.blue},
      -- separator = ' ',
      -- separator_highlight = {'NONE'},
   }
}


gls.right[1] = {
   DiffAdd = {
      provider  = vcs.diff_add,
      condition = condition.hide_in_width,
      icon      = ' ',
      highlight = {colors.green},
   }
}

gls.right[2] = {
   DiffRemove = {
      provider  = vcs.diff_remove,
      condition = condition.hide_in_width,
      icon      = ' ',
      highlight = {colors.red},
   }
}

gls.right[3] = {
   DiffModified = {
      provider  = vcs.diff_modified,
      condition = condition.hide_in_width,
      icon      = ' ',
      highlight = {colors.orange},
   }
}

gls.right[5] = {
   GitBranch = {
      provider  = 'GitBranch',
      condition = condition.check_git_workspace,
      highlight = {colors.violet, 'bold'},
      -- separator = ' ',
      -- separator_highlight = {'NONE'},
   }
}

gls.right[6] = {
   GitIcon = {
      provider            = function() return '' end,
      condition           = condition.check_git_workspace,
      separator           = ' ',
      -- separator_highlight = {'NONE'},
      highlight           = {colors.violet, 'bold'},
   }
}

gls.right[7] = {
   right_left_rounded = {
      provider            = function () return '' end,
      highlight           = {colors.light},
      separator           = ' ',
      separator_highlight = {'NONE'},
   },
}
gls.right[8] = {
   LineInfo = {
      provider            = 'LineColumn',
      separator           = '  ',
      separator_highlight = {'NONE', colors.light},
      highlight           = {colors.dark, colors.light},
   },
}

gls.right[9] = {
   PerCent = {
      provider            = 'LinePercent',
      separator           = ' ',
      separator_highlight = {'NONE', colors.light},
      highlight           = {colors.dark, colors.light, 'bold'},
   }
}

gls.right[10] = {
   RainbowBlue = {
      provider  = function() return '' end,
      highlight = {colors.light}
   },
}


gls.short_line_left[1] = {
   SFileName = {
      provider  = function ()
         return fn.pathshorten(fn.expand('%:F'))
      end,
      condition = condition.buffer_not_empty,
      highlight = {colors.fg, 'bold'}
   }
}


gls.short_line_right[1] = {
   GitBranch = {
      provider  = 'GitBranch',
      condition = condition.check_git_workspace,
      highlight = {colors.violet, 'bold'},
      -- separator = ' ',
      -- separator_highlight = {'NONE'},
   }
}

gls.short_line_right[2] = {
   GitIcon = {
      provider            = function() return '' end,
      condition           = condition.check_git_workspace,
      separator           = ' ',
      -- separator_highlight = {'NONE'},
      highlight           = {colors.violet, 'bold'},
   }
}

gls.short_line_right[3] = {
   BufferIcon = {
      provider  = 'FileIcon',
      separator = ' ',
      highlight = {
         require('galaxyline.provider_fileinfo').get_file_icon_color,
      },
   }
}
