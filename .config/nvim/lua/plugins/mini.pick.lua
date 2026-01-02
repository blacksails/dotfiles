return {
	"nvim-mini/mini.pick",
	opts = {},
	lazy = true,
	keys = {
		{ "<C-p>", desc = "Pick files" },
		{ "<leader>ps", desc = "Grep live" },
		{ "<leader>vh", desc = "Help topics" },
	},
	config = function(_, opts)
		local MiniPick = require("mini.pick")
		MiniPick.setup(opts)

		vim.keymap.set("n", "<C-p>", function()
			MiniPick.builtin.files({ tool = "rg" })
		end)
		vim.keymap.set("n", "<leader>ps", function()
			MiniPick.builtin.grep_live({ tool = "rg" })
		end)
		vim.keymap.set("n", "<leader>vh", function()
			MiniPick.builtin.help()
		end)
	end,
}
