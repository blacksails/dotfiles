return {
	"folke/trouble.nvim",
	dependencies = "nvim-mini/mini.icons",
	opts = {
		focus = true,
		auto_close = true,
	},
	keys = {
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
		{
			"<leader>cs",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = "Symbols (Trouble)",
		},
		{
			"<leader>cl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "LSP Definitions / references / ... (Trouble)",
		},
		{
			"<leader>vrr",
			"<cmd>Trouble lsp_references toggle<cr>",
			desc = "LSP references",
		},
		{
			"<leader>vm",
			"<cmd>Trouble lsp_implementations toggle<cr>",
			desc = "LSP implementations",
		},
	},
}
