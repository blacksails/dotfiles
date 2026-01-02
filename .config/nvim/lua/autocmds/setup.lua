local grp = vim.api.nvim_create_augroup("blacksails", { clear = true })

require("autocmds.ft.setup").setup(grp)
require("autocmds.trailing_whitespace").setup(grp)
