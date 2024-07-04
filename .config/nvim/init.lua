vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

vim.g.mapleader = " "
require("lazy").setup({
    spec = {
        import = "plugins",
    },
    change_detection = {
        notify = false,
    },
})
