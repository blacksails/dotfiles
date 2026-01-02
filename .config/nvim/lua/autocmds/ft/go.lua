local M = {}

function M.setup(grp)
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    	group = grp,
    	pattern = { "*.go" },
    	callback = function(ev)
    		vim.api.nvim_buf_call(ev.buf, function()
    			vim.bo.expandtab = false
    		end)
            vim.treesitter.start()
    	end,
    })
end

return M
