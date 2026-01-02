local M = {}

-- This ensures that files is stripped of trailing whitespace

function M.setup(grp)
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    	group = grp,
    	command = [[%s/\s\+$//e]],
    })
end

return M
