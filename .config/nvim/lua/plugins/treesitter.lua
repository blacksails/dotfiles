return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = "main",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
        },
        build = ':TSUpdate',
        config = function()
            local tree_sitter = require('nvim-treesitter')
            tree_sitter.setup()
            tree_sitter.install({ 'lua', 'go', 'gomod', 'gosum', 'yaml' })
        end,
    }
}
