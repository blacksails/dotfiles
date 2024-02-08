local ts = require('telescope')
ts.setup {
    defaults = {
        layout_config = {
            horizontal = {
                prompt_position = "top",
            },
        },
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
        },
        --file_ignore_patterns = { ".git", "node_modules" },
        sorting_strategy = "ascending",
    },
    extensions = {
        file_browser = {
            --theme = "ivy",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
                ["i"] = {
                    -- your custom insert mode mappings
                },
                ["n"] = {
                    -- your custom normal mode mappings
                },
            },
        },
    },
}

ts.load_extension("file_browser")
local builtin = require("telescope.builtin")

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
--vim.keymap.set("n", "<leader>pv", ts.extensions.file_browser.file_browser, {})
vim.keymap.set("n", "<leader>pv", function ()
    ts.extensions.file_browser.file_browser({
        path = "%:p:h",
        select_buffer = true,
    })
end, {})
vim.keymap.set("i", "<C-r>", function ()
    builtin.symbols({ sources = {"gitmoji"}})
end, {})
vim.keymap.set("i", "<C-t>", function ()
    builtin.symbols({ sources = {"emoji"}})
end, {})
