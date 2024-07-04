return {
    {
        "epwalsh/obsidian.nvim",
        lazy = false,
        ft = "markdown",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },

        opts = {
            workspaces = {
                {
                    name = "Vault",
                    path = "~/Dropbox/b/Vault",
                },
            },
        },
    }
}
