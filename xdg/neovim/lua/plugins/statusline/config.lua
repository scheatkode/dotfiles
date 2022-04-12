local has_statusline, statusline = pcall(require, 'lualine')

local buf_get_clients = vim.lsp.buf_get_clients

if not has_statusline then
   print('Tried loading plugin ... unsuccessfully ‼', 'lualine')
   return has_statusline
end

local has_status, status = pcall(require, 'lsp-status')

local function lspstatus ()
   if has_status and #buf_get_clients() > 0 then
      return status.status()
   end

   return ''
end

local config = {
   options = {
      always_divide_middle = true,
      component_separators = { left = ' ', right = ' '},
      disabled_filetypes = {},
      icons_enabled = true,
      section_separators = { left = ' ', right = ' '},
      theme = require('colors').current().lualine(),
   },
   sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename', lspstatus },
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
   },
   inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
   },
   tabline = {},
   extensions = {},
}

statusline.setup(config)
