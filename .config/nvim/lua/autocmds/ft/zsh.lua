local M = {}

function M.setup(grp)
	vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
		group = grp,
		pattern = { "*.zsh" },
		callback = function(_)
			vim.treesitter.start()
		end,
	})
end

return M
