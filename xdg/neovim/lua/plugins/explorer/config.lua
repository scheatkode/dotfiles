local log = require('log')

local has_tree, tree = pcall(require, 'nvim-tree')
-- local callback       = tree.nvim_tree_callback

if not has_tree then
   log.error('Tried loading plugin ... unsuccessfully ‼', 'nvim-tree')
   return has_tree
end

tree.setup {

   -- disables netrw completely.
   disable_netrw       = true,

   -- hijack netrw window on startup.
   hijack_netrw        = false,

   -- open the tree when running this setup function.
   open_on_setup       = false,

   -- will not open on setup if the filetype is in this
   -- list.
   ignore_ft_on_setup  = {},

   -- closes neovim automatically when  the tree is the
   -- last **WINDOW** in the view.
   auto_close          = false,

   -- opens the tree when changing/opening a new tab if
   -- the tree wasn't previously opened.
   open_on_tab         = false,

   -- hijack the  cursor in the  tree to put it  at the
   -- start of the filename.
   hijack_cursor       = false,

   -- updates  the  root  directory   of  the  tree  on
   -- `DirChanged` (when your run `:cd` usually).
   update_cwd          = false,

   -- update   the   focused    file   on   `BufEnter`,
   -- un-collapses  the  folders recursively  until  it
   -- finds the file.
   update_focused_file = {

      -- enables the feature.
      enable      = true,

      -- update the  root directory of the  tree to the
      -- one of  the folder containing the  file if the
      -- file is not under  the current root directory.
      -- only               relevant               when
      -- `update_focused_file.enable` is `true`.
      update_cwd  = true,

      -- list of buffer names / filetypes that will not
      -- update the  cwd if the file  isn't found under
      -- the current root directory. only relevant when
      -- `update_focused_file.update_cwd` is `true` and
      -- `update_focused_file.enable` is `true`.
      ignore_list = {}
   },

   -- configuration options for the system open command
   -- (`s` in the tree by default).
   system_open = {

      -- the command  to run  this, leaving  nil should
      -- work in most cases.
      cmd  = nil,

      -- the command arguments as a list.
      args = {}
   },

   -- show lsp diagnostics in the signcolumn
   diagnostics = {
      enable = true,
   },

   view = {

      -- width of  the window,  can be either  a number
      -- (columns) or a string in `%`.
      width = 40,

      -- side  of the  tree,  can be  one  of 'left'  |
      -- 'right' | 'top' | 'bottom'.
      side = 'left',

      -- if  true the  tree  will  resize itself  after
      -- opening a file.
      auto_resize = false,

      mappings = {

         -- custom only false will  merge the list with
         -- the  default mappings.  if `true`,  it will
         -- only use your list to set the mappings.
         custom_only = true,

         -- list  of  mappings  to   set  on  the  tree
         -- manually.
         list = {
            { key = {'<CR>', 'o'}, action = 'edit'               },
            { key = '<C-e>',       action = 'edit_in_place'      },
            { key = '<C-]>',       action = 'cd'                 },
            { key = '<C-v>',       action = 'vsplit'             },
            { key = '<C-x>',       action = 'split'              },
            { key = '<C-t>',       action = 'tabnew'             },
            { key = '<BS>',        action = 'close_node'         },
            { key = '<Tab>',       action = 'preview'            },
            { key = 'I',           action = 'toggle_ignored'     },
            { key = 'H',           action = 'toggle_dotfiles'    },
            { key = 'R',           action = 'refresh'            },
            { key = 'a',           action = 'create'             },
            { key = 'd',           action = 'remove'             },
            { key = 'D',           action = 'trash'              },
            { key = 'r',           action = 'rename'             },
            { key = '<C-r>',       action = 'full_rename'        },
            { key = 'x',           action = 'cut'                },
            { key = 'c',           action = 'copy'               },
            { key = 'p',           action = 'paste'              },
            { key = 'y',           action = 'copy_name'          },
            { key = 'Y',           action = 'copy_path'          },
            { key = 'gy',          action = 'copy_absolute_path' },
            { key = '-',           action = 'dir_up'             },
            { key = 'O',           action = 'system_open'        },
            { key = 'q',           action = 'close'              },
            { key = 'g?',          action = 'toggle_help'        },
            { key = 'W',           action = 'collapse_all'       },
         }
      }
   },

}
