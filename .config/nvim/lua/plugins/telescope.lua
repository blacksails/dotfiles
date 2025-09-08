local config = function(_, opts)
    local ts = require("telescope")
    ts.setup(opts)
    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
    vim.keymap.set("n", "<C-p>", builtin.git_files, {})
    vim.keymap.set("n", "<leader>ps", builtin.live_grep, {})
    vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
    vim.keymap.set("n", "<leader>pv", function()
        ts.extensions.file_browser.file_browser({
            path = "%:p:h",
            select_buffer = true,
        })
    end, {})
    vim.keymap.set("i", "<C-r>", function()
        builtin.symbols({ sources = { "gitmoji" } })
    end, {})
    vim.keymap.set("i", "<C-t>", function()
        builtin.symbols({ sources = { "emoji" } })
    end, {})
end

return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-symbols.nvim",
        },
        opts = {
            defaults = {
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                    },
                },
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--hidden",
                },
                file_ignore_patterns = { ".git", "node_modules" },
                sorting_strategy = "ascending",
            },
        },
        config = config,
    },
}
