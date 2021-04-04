local library    = require('lib')
local gl         = require('galaxyline')
local condition  = require('galaxyline.condition')
local diagnostic = require('galaxyline.provider_diagnostic')
local gls        = gl.section

gl.short_line_list = {'NvimTree', 'vista', 'dbui', 'packer'}

local colors = {
   bg       = '#202328',
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
}

gls.left[1] = {
   RainbowRed = {
      provider  = function() return '█ ' end,
      highlight = {colors.blue, colors.bg}
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
      highlight = {colors.red, colors.bg, 'bold'},
   },
}

gls.left[3] = {
   FileSize = {
      provider  = 'FileSize',
      condition = condition.buffer_not_empty,
      highlight = {colors.fg, colors.bg}
   }
}

gls.left[4] ={
   FileIcon = {
      provider  = 'FileIcon',
      condition = condition.buffer_not_empty,
      highlight = {
         require('galaxyline.provider_fileinfo').get_file_icon_color,
         colors.bg
      },
   },
}

gls.left[5] = {
   FileName = {
      provider  = {'FileName'},
      condition = condition.buffer_not_empty,
      highlight = {colors.magenta, colors.bg, 'bold'}
   }
}

gls.left[6] = {
   DiffAdd = {
      provider  = 'DiffAdd',
      condition = condition.hide_in_width,
      icon      = '  ',
      highlight = {colors.green, colors.bg},
   }
}

gls.left[7] = {
   DiffRemove = {
      provider  = 'DiffRemove',
      condition = condition.hide_in_width,
      icon      = '  ',
      highlight = {colors.red, colors.bg},
   }
}

gls.left[8] = {
   DiffModified = {
      provider  = 'DiffModified',
      condition = condition.hide_in_width,
      icon      = '  ',
      highlight = {colors.orange, colors.bg},
   }
}

gls.left[9] = {
   GitIcon = {
      provider            = function() return '' end,
      condition           = condition.check_git_workspace,
      separator           = ' ',
      separator_highlight = {'NONE', colors.bg},
      highlight           = {colors.violet, colors.bg, 'bold'},
   }
}

gls.left[10] = {
   GitBranch = {
      provider  = 'GitBranch',
      condition = condition.check_git_workspace,
      separator = ' ',
      highlight = {colors.violet, colors.bg, 'bold'},
      separator_highlight = {'NONE', colors.bg},
   }
}

gls.left[11] = {
   DiagnosticError = {
      provider  = 'DiagnosticError',
      icon      = '⬤ ',
      highlight = {colors.red, colors.bg},
      separator = ' ',
      separator_highlight = {'NONE', colors.bg},
   }
}

gls.left[12] = {
   DiagnosticWarn = {
      provider  = 'DiagnosticWarn',
      icon      = '⬤ ',
      highlight = {colors.yellow, colors.bg},
      separator = ' ',
      separator_highlight = {'NONE', colors.bg},
   }
}

gls.left[13] = {
   DiagnosticHint = {
      provider  = 'DiagnosticHint',
      icon      = '⬤ ',
      highlight = {colors.cyan, colors.bg},
      separator = ' ',
      separator_highlight = {'NONE', colors.bg},
   }
}

gls.left[14] = {
   DiagnosticInfo = {
      provider  = 'DiagnosticInfo',
      icon      = '⬤ ',
      highlight = {colors.blue, colors.bg},
      separator = ' ',
      separator_highlight = {'NONE', colors.bg},
   }
}

gls.right[1] = {
   FileEncode = {
      provider            = 'FileEncode',
      separator           = ' ',
      separator_highlight = {'NONE', colors.bg},
      highlight           = {colors.cyan, colors.bg, 'bold'}
   }
}

gls.right[2] = {
   FileFormat = {
      provider            = 'FileFormat',
      separator           = ' ',
      separator_highlight = {'NONE', colors.bg},
      highlight           = {colors.cyan, colors.bg, 'bold'}
   }
}

gls.right[3] = {
   LineInfo = {
      provider            = 'LineColumn',
      separator           = '  ',
      separator_highlight = {'NONE',colors.bg},
      highlight           = {colors.fg, colors.bg},
   },
}

gls.right[4] = {
   PerCent = {
      provider            = 'LinePercent',
      separator           = ' ',
      separator_highlight = {'NONE', colors.bg},
      highlight           = {colors.fg, colors.bg, 'bold'},
   }
}

gls.right[5] = {
   RainbowBlue = {
      provider  = function() return ' █' end,
      highlight = {colors.blue, colors.bg}
   },
}

gls.short_line_left[1] = {
   BufferType = {
      provider            = 'FileTypeName',
      separator           = ' ',
      separator_highlight = {'NONE', colors.bg},
      highlight           = {colors.blue, colors.bg, 'bold'}
   }
}

gls.short_line_left[2] = {
   SFileName = {
      provider  = 'SFileName',
      condition = condition.buffer_not_empty,
      highlight = {colors.fg, colors.bg, 'bold'}
   }
}

gls.short_line_right[1] = {
   BufferIcon = {
      provider  = 'BufferIcon',
      highlight = {colors.fg, colors.bg}
   }
}
