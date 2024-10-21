return {
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = false,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},

		opts = {
			workspaces = {
				{
					name = "Vault",
					path = "~/Dropbox/b/Vault",
				},
			},
			daily_notes = {
				folder = "daily-notes",
			},
			completion = {
				nvim_cmp = true,
			},
			preferred_link_style = "markdown",
			ui = {
				checkboxes = {
					[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
					["x"] = { char = "", hl_group = "ObsidianDone" },
					["!"] = { char = "", hl_group = "ObsidianImportant" },
				},
			},
		},
		config = function(_, opts)
			require("obsidian").setup(opts)

			vim.keymap.set("n", "<leader>od", ":ObsidianToday<CR>")
			vim.keymap.set("n", "<leader>of", ":ObsidianQuickSwitch<CR>")
			vim.keymap.set("n", "<leader>os", ":ObsidianSearch<CR>")
		end,
	},
}
