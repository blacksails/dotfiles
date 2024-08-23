local function on_attach(bufnr)
    local api = require "nvim-tree.api"

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- custom mappings
    -- vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end

local function config()
    local api = require "nvim-tree.api"

    vim.keymap.set('n', '<F3>', function()
        if api.tree.is_tree_buf() then
            api.tree.close()
        else
            api.tree.open()
        end
    end)

    require("nvim-tree").setup({
        on_attach = on_attach,
        filters = {
            exclude = {
                ".DS_Store",
            }
        },
        view = {
            width = 45,
            relativenumber = true,
        },
        actions = {
            open_file = {
                window_picker = {
                    enable = false
                }
            }
        },
        renderer = {
            group_empty = true
        }
    })
end

return {
    {
        "nvim-tree/nvim-tree.lua",
        lazy = false,
        dependencies = {
            { "nvim-tree/nvim-web-devicons" }
        },
        config = config
    }
}
