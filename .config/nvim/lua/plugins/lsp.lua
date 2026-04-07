return {
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
		opts = {
			signature = {
				enabled = true,
			},
			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 100,
				},
				menu = {
					draw = {
						columns = { { "label", "label_description", gap = 1 }, { "kind" } },
					},
				},
			},
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "saghen/blink.cmp" },
		},
		config = function()
			vim.diagnostic.config({
				virtual_text = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚",
						[vim.diagnostic.severity.WARN] = "󰀪",
						[vim.diagnostic.severity.INFO] = "󰌶",
						[vim.diagnostic.severity.HINT] = "󰋽",
					},
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local bufnr = event.buf
					local map = function(m, lhs, desc, rhs)
						local opts = {
							buffer = bufnr,
							desc = desc,
						}
						vim.keymap.set(m, lhs, rhs, opts)
					end

					-- LSP actions
					map("n", "K", "Show signature", function()
						vim.lsp.buf.hover()
					end)
					map("n", "gd", "Go to definition", function()
						vim.lsp.buf.definition()
					end)
					map("n", "gD", "Go to declaration", function()
						vim.lsp.buf.declaration()
					end)
					map("n", "<leader>vrn", "Rename", function()
						vim.lsp.buf.rename()
					end)
					map("n", "<leader>vca", "Code action", function()
						vim.lsp.buf.code_action()
					end)
					map("n", "<leader>vd", "Show diagnostics", function()
						vim.diagnostic.open_float()
					end)
					map("n", "[d", "Next diagnostic", function()
						vim.diagnostic.jump({ count = 1 })
					end)
					map("n", "]d", "Previous diagnostic", function()
						vim.diagnostic.jump({ count = -1 })
					end)
					map("n", "<leader>vws", "Workspace symbol", function()
						vim.lsp.buf.workspace_symbol()
					end)
				end,
			})
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				"gopls",
				"lua_ls",
				"bashls",
			},
		},
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)

			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						analyses = {
							copylocks = false,
						},
					},
				},
			})

			vim.lsp.config("bashls", {
				filetypes = { "bash", "sh", "zsh" },
			})
		end,
	},
}
