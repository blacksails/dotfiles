return {
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
		opts = {
			signature = {
				enabled = true,
			},
		},
		opts_extend = { "sources.default" },
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
						vim.diagnostic.goto_next()
					end)
					map("n", "]d", "Previous diagnostic", function()
						vim.diagnostic.goto_prev()
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
				"bash-language-server",
			},
		},
	},
	--{
	--    "ray-x/lsp_signature.nvim",
	--    opts = {
	--        bind = true, -- This is mandatory, otherwise border config won't get registered.
	--        hint_enable = false,
	--        handler_opts = {
	--            border = "rounded",
	--        },
	--    },
	--},
}
