return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			go = { "goimports" },
		},
		format_on_save = function(bufnr)
			return { timeout_ms = 500, lsp_format = "fallback" }
		end,
	},
}
