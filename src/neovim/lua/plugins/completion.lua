-- local function apply(keymaps)
--    for _, map in ipairs(keymaps) do
--       vim.api.nvim_set_keymap(unpack(map))
--    end

--    return keymaps
-- end

-- vim.api.nvim_exec('autocmd BufEnter * lua require("completion").on_attach()', false)

-- local mappings = {

--    -- i like to trigger autocompletion manually sometimes.

--    {'i', '<tab>',   'pumvisible() ? "\\<c-n>" : "\\<tab>"',   { expr = true, noremap = true }},
--    {'i', '<s-tab>', 'pumvisible() ? "\\<c-p>" : "\\<s-tab>"', { expr = true, noremap = true }},

--    {'i', '<tab>',   '<Plug>(completion_smart_tab)',   {}},
--    {'i', '<s-tab>', '<Plug>(completion_smart_s_tab)', {}},

--    {'i', '<c-p>', '<Plug>(completion_trigger)', {}},
--    {'i', '<c-n>', '<Plug>(completion_trigger)', {}},

-- }


-- vim.g.completion_enable_auto_popup      = 1
-- vim.g.completion_matching_smart_case    = 1
-- vim.g.completion_trigger_keyword_length = 2
-- vim.g.completion_matching_strategy_list = {
--    'exact',
--    'substring',
--    'fuzzy',
--    'all',
-- }

-- return apply(mappings)

require('compe').setup({
   enabled = true,
   autocomplete = true,
   debug = false,
   min_length = 1,
   preselect = 'enable',
   throttle_time = 80,
   source_timeout = 200,
   incomplete_delay = 400,
   max_abbr_width = 100,
   max_kind_width = 100,
   max_menu_width = 100,
   documentation = true,

   source = {
      path                  = {kind = '  '},
      buffer                = {kind = '  '},
      calc                  = {kind = '  '},
      vsnip                 = {kind = '  '},
      nvim_lsp              = {kind = '  '},
      -- nvim_lua              = {kind = '  '},
      nvim_lua              = false,
      spell                 = {kind = '  '},
      tags                  = false,
      vim_dadbod_completion = true,
      snippets_nvim         = {kind = '  '},
      ultisnips             = {kind = '  '},
      treesitter            = {kind = '  '},
   }
})

local t = function (s)
   return vim.api.nvim_replace_termcodes(s, true, true, true)
end

local check_back_space = function ()
   local col = vim.fn.col('.') - 1

   if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
      return true
   end

   return false
end

-- use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder

_G.tab_complete = function ()
   if vim.fn.pumvisible() == 1 then
      return t '<C-n>'
   elseif vim.fn.call('vsnip#available', {1}) == 1 then
      return t '<plug>(vsnip-expand-or-jump)'
   elseif check_back_space() then
      return t '<tab>'
   else
      return vim.fn['compe#complete']()
   end
end

_G.s_tab_complete = function ()
   if vim.fn.pumvisible() == 1 then
      return t '<c-p>'
   elseif vim.fn.call('vsnip#jumpable', {-1}) == 1 then
      return t '<plug>(vsnip-jump-prev)'
   else
      return t '<s-tab>'
   end
end

vim.api.nvim_set_keymap('i', '<tab>',   'v:lua.tab_complete()',   {expr = true})
vim.api.nvim_set_keymap('s', '<tab>',   'v:lua.tab_complete()',   {expr = true})
vim.api.nvim_set_keymap('i', '<s-tab>', 'v:lua.s_tab_complete()', {expr = true})
vim.api.nvim_set_keymap('s', '<s-tab>', 'v:lua.s_tab_complete()', {expr = true})
