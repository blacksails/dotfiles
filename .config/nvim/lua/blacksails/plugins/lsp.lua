return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Support
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Autocompletion
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',

            -- Snippets
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',
        },
        config = function ()
            local lsp = require("lsp-zero")
            lsp.preset("recommended")
            lsp.ensure_installed({
                'tsserver',
                'rust_analyzer',
                'gopls',
                'lua_ls',
            })
            lsp.nvim_workspace()

            local cmp = require('cmp')
            local cmp_select = {behavior = cmp.SelectBehavior.Select}

            local cmp_mappings = lsp.defaults.cmp_mappings({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
                ['<Tab>'] = nil,
                ['<S-Tab>'] = nil,
            })
            lsp.setup_nvim_cmp({
                mapping = cmp_mappings
            })

            lsp.set_preferences({
                suggest_lsp_servers = false,
                sign_icons = {
                    error = '󰅚',
                    warn = '󰀪',
                    hint = '󰌶',
                    info = '󰋽'
                }
            })

            lsp.on_attach(function(_, bufnr)
                local opts = {buffer = bufnr, remap = false}
                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
                vim.keymap.set("n", "<leader>vm", function () vim.lsp.buf.implementation() end, opts)
            end)

            lsp.setup()

            vim.diagnostic.config({
                virtual_text = true
            })
        end
    },
    {
        'nvimtools/none-ls.nvim',
        config = function ()
            local null_ls = require('null-ls')
            local grp = vim.api.nvim_create_augroup("LspFormatting", {})

            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.gofmt,
                    null_ls.builtins.formatting.goimports,
                    null_ls.builtins.formatting.prettier.with({
                        filetypes = {"javascript", "typescript", "typescriptreact"}
                    }),
                },
                on_attach = function(client, bufnr)
                    if client.supports_method('textDocument/formatting') then
                        vim.api.nvim_clear_autocmds({group = grp, buffer = bufnr})
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            group = grp,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 3000 })
                            end,
                        })
                    end
                end,
            })
        end
    },
    {
        'ray-x/lsp_signature.nvim',
        opts = {
            bind = true, -- This is mandatory, otherwise border config won't get registered.
            hint_enable = false,
            handler_opts = {
                border = "rounded"
            }
        }
    }
}
