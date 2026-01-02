return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-mini/mini.pick",
	},
	keys = {
		{ "<leader>ov", "<cmd>ObsidianOpen<cr>", desc = "Open Obsidian Vault" },
		{ "<leader>of", "<cmd>ObsidianFollowLink<cr>", desc = "Follow Obsidian Link" },
		{ "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Search in Obsidian Vault" },
		{ "<leader>op", "<cmd>ObsidianQuickSwitch<cr>", desc = "Search for files in Obsidian" },
	},
	opts = {
		workspaces = {
			{
				name = "personal",
				path = "~/Vaults/Benjamin",
			},
			{
				name = "shared",
				path = "~/Vaults/Shared",
			},
		},
		picker = {
			name = "mini.pick",
		},
		mappings = {
			-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			-- Toggle check-boxes.
			["<leader>ch"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true },
			},
			-- Smart action depending on context, either follow link or toggle checkbox.
			["<cr>"] = {
				action = function()
					return require("obsidian").util.smart_action()
				end,
				opts = { buffer = true, expr = true },
			},
		},
	},
}
