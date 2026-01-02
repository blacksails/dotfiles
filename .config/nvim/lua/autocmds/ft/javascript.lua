local M = {}

function M.setup(grp)
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        group = grp,
        pattern = { "*.ts", "*.js" },
        callback = function(ev)
            vim.api.nvim_buf_call(ev.buf, function()
                vim.bo.tabstop = 2
                vim.bo.softtabstop = 2
                vim.bo.shiftwidth = 2
            end)
        end,
    })
end

return M
