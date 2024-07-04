return {
    {
        "RRethy/vim-illuminate",
        opts = {
            providers = {
                'lsp',
                'treesitter',
                'regex',
            },
            delay = 50,
            filetypes_denylist = {
                'dirbuf',
                'dirvish',
                'fugitive',
                'NvimTree',
            },
            under_cursor = false,
        },
        config = function (_, opts)
            require('illuminate').configure(opts)
        end
    }
}
