local M = {}

function M.setup(grp)
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    	group = grp,
    	pattern = { "*.yaml", "*.yml" },
    	callback = function(ev)
    		vim.api.nvim_buf_call(ev.buf, function()
    			if vim.fn.search("{{.\\+}}", "nw") ~= 0 then
    				vim.bo.filetype = "gotmpl"
    			end
    			vim.bo.tabstop = 2
    			vim.bo.softtabstop = 2
    			vim.bo.shiftwidth = 2
    		end)
    	end,
    })
end

return M
