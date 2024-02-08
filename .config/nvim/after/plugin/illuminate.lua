require('illuminate').configure({
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
    },
    under_cursor = false,
})
