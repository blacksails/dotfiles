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
                    "omnisharp",
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
        "mfussenegger/nvim-jdtls",
        config = function()
            local features = {
                -- change this to `true` to enable codelens
                codelens = false,

                -- change this to `true` if you have `nvim-dap`,
                -- `java-test` and `java-debug-adapter` installed
                debugger = false,
            }

            local root_files = {
                ".git",
                "mvnw",
                "gradlew",
                "pom.xml",
                "build.gradle",
            }
            local java_cmds = vim.api.nvim_create_augroup("java_cmds", { clear = true })
            local cache_vars = {}
            local mason_registry = require("mason-registry")

            local function get_jdtls_paths()
                if cache_vars.paths then
                    return cache_vars.paths
                end

                local path = {}

                path.data_dir = vim.fn.stdpath("cache") .. "/nvim-jdtls"

                local jdtls_install = mason_registry.get_package("jdtls"):get_install_path()

                path.java_agent = jdtls_install .. "/lombok.jar"
                path.launcher_jar = vim.fn.glob(jdtls_install .. "/plugins/org.eclipse.equinox.launcher_*.jar")

                if vim.fn.has("mac") == 1 then
                    path.platform_config = jdtls_install .. "/config_mac"
                elseif vim.fn.has("unix") == 1 then
                    path.platform_config = jdtls_install .. "/config_linux"
                elseif vim.fn.has("win32") == 1 then
                    path.platform_config = jdtls_install .. "/config_win"
                end

                path.bundles = {}

                ---
                -- Include java-test bundle if present
                ---
                local java_test_path = mason_registry.get_package("java-test"):get_install_path()

                local java_test_bundle = vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar"), "\n")

                if java_test_bundle[1] ~= "" then
                    vim.list_extend(path.bundles, java_test_bundle)
                end

                ---
                -- Include java-debug-adapter bundle if present
                ---
                local java_debug_path = mason_registry.get_package("java-debug-adapter"):get_install_path()

                local java_debug_bundle = vim.split(
                    vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"),
                    "\n"
                )

                if java_debug_bundle[1] ~= "" then
                    vim.list_extend(path.bundles, java_debug_bundle)
                end

                ---
                -- Useful if you're starting jdtls with a Java version that's
                -- different from the one the project uses.
                ---
                path.runtimes = {
                    -- Note: the field `name` must be a valid `ExecutionEnvironment`,
                    -- you can find the list here:
                    -- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
                    --
                    -- This example assume you are using sdkman: https://sdkman.io
                    -- {
                    --   name = 'JavaSE-17',
                    --   path = vim.fn.expand('~/.sdkman/candidates/java/17.0.6-tem'),
                    -- },
                    -- {
                    --   name = 'JavaSE-18',
                    --   path = vim.fn.expand('~/.sdkman/candidates/java/18.0.2-amzn'),
                    -- },
                }

                cache_vars.paths = path

                return path

                ---
                -- we will use this function to get all the paths
                -- we need to start the LSP server.
                ---
            end

            local function enable_codelens(bufnr)
                pcall(vim.lsp.codelens.refresh)

                vim.api.nvim_create_autocmd("BufWritePost", {
                    buffer = bufnr,
                    group = java_cmds,
                    desc = "refresh codelens",
                    callback = function()
                        pcall(vim.lsp.codelens.refresh)
                    end,
                })
            end

            local function enable_debugger(bufnr)
                require("jdtls").setup_dap({ hotcodereplace = "auto" })
                require("jdtls.dap").setup_dap_main_class_configs()

                local opts = { buffer = bufnr }
                vim.keymap.set("n", "<leader>df", "<cmd>lua require('jdtls').test_class()<cr>", opts)
                vim.keymap.set("n", "<leader>dn", "<cmd>lua require('jdtls').test_nearest_method()<cr>", opts)
            end

            local function jdtls_on_attach(_, bufnr)
                if features.debugger then
                    enable_debugger(bufnr)
                end

                if features.codelens then
                    enable_codelens(bufnr)
                end

                -- The following mappings are based on the suggested usage of nvim-jdtls
                -- https://github.com/mfussenegger/nvim-jdtls#usage

                local opts = { buffer = bufnr }
                vim.keymap.set("n", "<A-o>", "<cmd>lua require('jdtls').organize_imports()<cr>", opts)
                vim.keymap.set("n", "crv", "<cmd>lua require('jdtls').extract_variable()<cr>", opts)
                vim.keymap.set("x", "crv", "<esc><cmd>lua require('jdtls').extract_variable(true)<cr>", opts)
                vim.keymap.set("n", "crc", "<cmd>lua require('jdtls').extract_constant()<cr>", opts)
                vim.keymap.set("x", "crc", "<esc><cmd>lua require('jdtls').extract_constant(true)<cr>", opts)
                vim.keymap.set("x", "crm", "<esc><Cmd>lua require('jdtls').extract_method(true)<cr>", opts)
            end

            local function jdtls_setup(_)
                local jdtls = require("jdtls")

                local path = get_jdtls_paths()
                local data_dir = path.data_dir .. "/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

                if cache_vars.capabilities == nil then
                    jdtls.extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

                    local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
                    cache_vars.capabilities = vim.tbl_deep_extend(
                        "force",
                        vim.lsp.protocol.make_client_capabilities(),
                        ok_cmp and cmp_lsp.default_capabilities() or {}
                    )
                end

                -- The command that starts the language server
                -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
                local cmd = {
                    -- 💀
                    "java",

                    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                    "-Dosgi.bundles.defaultStartLevel=4",
                    "-Declipse.product=org.eclipse.jdt.ls.core.product",
                    "-Dlog.protocol=true",
                    "-Dlog.level=ALL",
                    "-javaagent:" .. path.java_agent,
                    "-Xms1g",
                    "--add-modules=ALL-SYSTEM",
                    "--add-opens",
                    "java.base/java.util=ALL-UNNAMED",
                    "--add-opens",
                    "java.base/java.lang=ALL-UNNAMED",

                    -- 💀
                    "-jar",
                    path.launcher_jar,

                    -- 💀
                    "-configuration",
                    path.platform_config,

                    -- 💀
                    "-data",
                    data_dir,
                }

                local lsp_settings = {
                    java = {
                        -- jdt = {
                        --   ls = {
                        --     vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx1G -Xms100m"
                        --   }
                        -- },
                        eclipse = {
                            downloadSources = true,
                        },
                        configuration = {
                            updateBuildConfiguration = "interactive",
                            runtimes = path.runtimes,
                        },
                        maven = {
                            downloadSources = true,
                        },
                        implementationsCodeLens = {
                            enabled = true,
                        },
                        referencesCodeLens = {
                            enabled = true,
                        },
                        -- inlayHints = {
                        --   parameterNames = {
                        --     enabled = 'all' -- literals, all, none
                        --   }
                        -- },
                        format = {
                            enabled = true,
                            -- settings = {
                            --   profile = 'asdf'
                            -- },
                        },
                    },
                    signatureHelp = {
                        enabled = true,
                    },
                    completion = {
                        favoriteStaticMembers = {
                            "org.hamcrest.MatcherAssert.assertThat",
                            "org.hamcrest.Matchers.*",
                            "org.hamcrest.CoreMatchers.*",
                            "org.junit.jupiter.api.Assertions.*",
                            "java.util.Objects.requireNonNull",
                            "java.util.Objects.requireNonNullElse",
                            "org.mockito.Mockito.*",
                        },
                    },
                    contentProvider = {
                        preferred = "fernflower",
                    },
                    extendedClientCapabilities = jdtls.extendedClientCapabilities,
                    sources = {
                        organizeImports = {
                            starThreshold = 9999,
                            staticStarThreshold = 9999,
                        },
                    },
                    codeGeneration = {
                        toString = {
                            template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                        },
                        useBlocks = true,
                    },
                }

                -- This starts a new client & server,
                -- or attaches to an existing client & server depending on the `root_dir`.
                jdtls.start_or_attach({
                    cmd = cmd,
                    settings = lsp_settings,
                    on_attach = jdtls_on_attach,
                    capabilities = cache_vars.capabilities,
                    root_dir = jdtls.setup.find_root(root_files),
                    flags = {
                        allow_incremental_sync = true,
                    },
                    init_options = {
                        bundles = path.bundles,
                    },
                })
            end

            vim.api.nvim_create_autocmd("FileType", {
                group = java_cmds,
                pattern = { "java" },
                desc = "Setup jdtls",
                callback = jdtls_setup,
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
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.gofmt,
                    null_ls.builtins.formatting.goimports,
                    null_ls.builtins.formatting.prettier.with({
                        filetypes = { "javascript", "typescript", "typescriptreact" },
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
