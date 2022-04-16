local function setup ()
   vim.keymap.set('n',        '<leader>dv', require('dapui').toggle, {desc = 'Toggle debugging visuals'})
   vim.keymap.set({'n', 'v'}, '<leader>de', require('dapui').eval,   {desc = 'Evaluate'})
end

return {
   setup = setup
}
