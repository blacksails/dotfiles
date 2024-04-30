return {
    {
        "folke/trouble.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        opts = {},
        config = function(_, opts)
            require("trouble").setup(opts)
            vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
                {silent = true, noremap = true}
            )
        end
    },
}
