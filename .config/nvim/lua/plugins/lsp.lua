return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
        },
        config = function()
            local lspconfig = require("lspconfig")

            lspconfig.util.on_setup = lspconfig.util.add_hook_after(
                lspconfig.util.on_setup,
                function(config, user_config)
                    config.capabilities = vim.tbl_deep_extend(
                        "force",
                        config.capabilities,
                        require("cmp_nvim_lsp").default_capabilities(),
                        vim.tbl_get(user_config, "capabilities") or {}
                    )
                end
            )

            vim.diagnostic.config({
                virtual_text = true,
                float = { border = "rounded" },
            })

            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

            vim.lsp.handlers["textDocument/signatureHelp"] =
                vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

            local command = vim.api.nvim_create_user_command

            command("LspWorkspaceAdd", function()
                vim.lsp.buf.add_workspace_folder()
            end, { desc = "Add folder to workspace" })

            command("LspWorkspaceList", function()
                vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, { desc = "List workspace folders" })

            command("LspWorkspaceRemove", function()
                vim.lsp.buf.remove_workspace_folder()
            end, { desc = "Remove folder from workspace" })

            -- Setup diagnositc signs
            local function sign(opts)
                vim.fn.sign_define(opts.name, { texthl = opts.name, text = opts.text, numhl = "" })
            end
            sign({ name = "DiagnosticSignError", text = "󰅚" })
            sign({ name = "DiagnosticSignWarn", text = "󰀪" })
            sign({ name = "DiagnosticSignHint", text = "󰌶" })
            sign({ name = "DiagnosticSignInfo", text = "󰋽" })

            local function lsp_format(input)
                local name
                local async = input.bang

                if input.args ~= "" then
                    name = input.args
                end

                vim.lsp.buf.format({ async = async, name = name })
            end

            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    local bufnr = event.buf
                    local map = function(m, lhs, rhs)
                        local opts = { buffer = bufnr }
                        vim.keymap.set(m, lhs, rhs, opts)
                    end

                    vim.api.nvim_buf_create_user_command(bufnr, "LspFormat", lsp_format, {
                        bang = true,
                        nargs = "?",
                        desc = "Format buffer with language server",
                    })

                    -- LSP actions
                    map("n", "K", function()
                        vim.lsp.buf.hover()
                    end)
                    map("n", "gd", function()
                        vim.lsp.buf.definition()
                    end)
                    map("n", "gD", function()
                        vim.lsp.buf.declaration()
                    end)
                    map("n", "<leader>vm", function()
                        vim.lsp.buf.implementation()
                    end)
                    map("n", "<leader>vrr", function()
                        vim.lsp.buf.references()
                    end)
                    map("i", "<C-h>", function()
                        vim.lsp.buf.signature_help()
                    end)
                    map("n", "<leader>vrn", function()
                        vim.lsp.buf.rename()
                    end)
                    map("n", "<leader>vca", function()
                        vim.lsp.buf.code_action()
                    end)
                    map("n", "<leader>vd", function()
                        vim.diagnostic.open_float()
                    end)
                    map("n", "[d", function()
                        vim.diagnostic.goto_next()
                    end)
                    map("n", "]d", function()
                        vim.diagnostic.goto_prev()
                    end)
                    map("n", "<leader>vws", function()
                        vim.lsp.buf.workspace_symbol()
                    end)
                end,
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        config = true,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
        },
        config = function()
            local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "tsserver",
                    "gopls",
                    "lua_ls",
                    "jdtls",
                },
                handlers = {
                    function(server)
                        require("lspconfig")[server].setup({
                            capabilities = lsp_capabilities,
                        })
                    end,
                    jdtls = function() end,
                    lua_ls = function()
                        require("lspconfig").lua_ls.setup({
                            on_init = function(client)
                                local path = client.workspace_folders[1].name
                                if
                                    vim.loop.fs_stat(path .. "/.luarc.json")
                                    or vim.loop.fs_stat(path .. "/.luarc.jsonc")
                                then
                                    return
                                end

                                client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                                    runtime = {
                                        -- Tell the language server which version of Lua you're using
                                        -- (most likely LuaJIT in the case of Neovim)
                                        version = "LuaJIT",
                                    },
                                    -- Make the server aware of Neovim runtime files
                                    workspace = {
                                        checkThirdParty = false,
                                        library = {
                                            vim.env.VIMRUNTIME,
                                            -- Depending on the usage, you might want to add additional paths here.
                                            -- "${3rd}/luv/library"
                                            -- "${3rd}/busted/library",
                                        },
                                        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                                        -- library = vim.api.nvim_get_runtime_file("", true)
                                    },
                                })
                            end,
                            settings = {
                                Lua = {},
                            },
                        })
                    end,
                },
            })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "L3MON4D3/LuaSnip" },
            { "saadparwaiz1/cmp_luasnip" },
        },
        config = function()
            local cmp = require("cmp")
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            local opts = {
                sources = {
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "luasnip" },
                },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
            }
            cmp.setup(opts)
        end,
    },
    {
        "rafamadriz/friendly-snippets",
    },
    {
        "nvimtools/none-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            local grp = vim.api.nvim_create_augroup("LspFormatting", {})

            null_ls.setup({
                sources = {
                    -- Formatting
                    null_ls.builtins.formatting.prettier.with({
                        filetypes = { "javascript", "typescript" },
                    }),
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.gofmt,
                    null_ls.builtins.formatting.goimports,
                    null_ls.builtins.formatting.google_java_format.with({
                        extra_args = { "--aosp" },
                    }),
                },
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({ group = grp, buffer = bufnr })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = grp,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 3000 })
                            end,
                        })
                    end
                end,
            })
        end,
    },
    {
        "ray-x/lsp_signature.nvim",
        opts = {
            bind = true, -- This is mandatory, otherwise border config won't get registered.
            hint_enable = false,
            handler_opts = {
                border = "rounded",
            },
        },
    },
}
