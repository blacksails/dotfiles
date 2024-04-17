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
