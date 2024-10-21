local grp = vim.api.nvim_create_augroup("blacksails", { clear = true })

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

-- vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
--   group = grp,
--   pattern = {"*.java"},
--   callback = function (ev)
--     vim.api.nvim_buf_call(ev.buf, function()
-- 	  vim.bo.tabstop = 2
-- 	  vim.bo.softtabstop = 2
-- 	  vim.bo.shiftwidth = 2
--     end)
--   end,
-- })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	group = grp,
	pattern = { "*.Jenkinsfile", "Jenkinsfile" },
	callback = function(ev)
		vim.api.nvim_buf_call(ev.buf, function()
			vim.bo.filetype = "groovy"
		end)
	end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	group = grp,
	pattern = { "*.go" },
	callback = function(ev)
		vim.api.nvim_buf_call(ev.buf, function()
			vim.bo.expandtab = false
		end)
	end,
})

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

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = grp,
	command = [[%s/\s\+$//e]],
})
