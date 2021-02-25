local function apply(keymaps)
   for _, map in ipairs(keymaps) do
      vim.api.nvim_set_keymap(unpack(map))
   end

   return keymaps
end

vim.api.nvim_exec('autocmd BufEnter * lua require("completion").on_attach()', false)

local mappings = {

   -- i like to trigger autocompletion manually sometimes.

   {'i', '<tab>',   'pumvisible() ? "\\<c-n>" : "\\<tab>"',   { expr = true, noremap = true }},
   {'i', '<s-tab>', 'pumvisible() ? "\\<c-p>" : "\\<s-tab>"', { expr = true, noremap = true }},

   {'i', '<tab>',   '<Plug>(completion_smart_tab)',   {}},
   {'i', '<s-tab>', '<Plug>(completion_smart_s_tab)', {}},

   {'i', '<c-p>', '<Plug>(completion_trigger)', {}},
   {'i', '<c-n>', '<Plug>(completion_trigger)', {}},

}


vim.g.completion_enable_auto_popup      = 1
vim.g.completion_matching_smart_case    = 1
vim.g.completion_trigger_keyword_length = 2
vim.g.completion_matching_strategy_list = {
   'exact',
   'substring',
   'fuzzy',
   'all',
}

return apply(mappings)
