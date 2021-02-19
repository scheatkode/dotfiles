require('nvim-treesitter.configs').setup {
    ensure_installed = 'maintained',
    highlight = {
        enable = true,
    },
    lsp_interop = {
        enable = true,
    },
    indent = {
        enable = true,
    },

    -- playground specific
    playground = {
        enable          = true,
        updatetime      = 25,    -- debounced time for highlighting nodes
        persist_queries = false, -- persistence across vim sessions
    },
}
