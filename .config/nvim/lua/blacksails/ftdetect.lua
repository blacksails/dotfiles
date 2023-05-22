local grp = vim.api.nvim_create_augroup("blacksails", { clear = true })

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  group = grp,
  pattern = {"*.yaml", "*.yml"},
  callback = function (ev)
    vim.api.nvim_buf_call(ev.buf, function()
      if vim.fn.search("{{.\\+}}", "nw") ~= 0 then
        vim.bo.filetype = "gotmpl"
      end
    end)
  end,
})

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  group = grp,
  pattern = {"*.Jenkinsfile", "Jenkinsfile"},
  callback = function (ev)
    vim.api.nvim_buf_call(ev.buf, function()
      vim.bo.filetype = "groovy"
    end)
  end,
})
