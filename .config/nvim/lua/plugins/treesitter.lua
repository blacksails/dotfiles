return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/nvim-treesitter-context",
            "nvim-treesitter/playground",
        },
        build = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
        opts = {
            ensure_installed = { 'lua', 'go', 'gomod', 'gosum', 'yaml' },
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
                disable = { "java" },
            },
            textobjects = {
                select = {
                    enable = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner"
                    }
                }
            }
        },
        config = function (_, opts)
            require('nvim-treesitter.configs').setup(opts)
            --local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
            --parser_config.gotmpl = {
            --    install_info = {
            --        url = "https://github.com/ngalaiko/tree-sitter-go-template",
            --        files = { "src/parser.c" },
            --    },
            --    filetype = "gotmpl",
            --    used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl", "yaml" }
            --}

            --local queries = require('vim.treesitter.query')
            --queries.set("gotmpl", "injections", '(text) @yaml @combined')
        end,
    }
}
