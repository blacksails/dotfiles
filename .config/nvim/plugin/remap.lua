vim.g.mapleader = " "

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

-- page up/down and center
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- keep search centered
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- paste from clipboard
--map("x", "<leader>p", [["_dP]])

-- yank to system clipboard
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])

-- delete to black hole register (don't overwrite clipboard)
map({ "n", "v" }, "<leader>d", [["_d]])

-- disable Ex mode
map("n", "Q", "<nop>")
-- format current buffer with LSP
map("n", "<leader>f", vim.lsp.buf.format)

-- quickfix list navigation (centered)
map("n", "<C-k>", "<cmd>cnext<CR>zz")
map("n", "<C-j>", "<cmd>cprev<CR>zz")
-- location list navigation (centered)
map("n", "<leader>k", "<cmd>lnext<CR>zz")
map("n", "<leader>j", "<cmd>lprev<CR>zz")

-- search and replace word under cursor
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
