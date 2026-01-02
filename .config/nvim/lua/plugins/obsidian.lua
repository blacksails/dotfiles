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
		{ "<leader>ov", "<cmd>Obsidian open<cr>", desc = "Open Obsidian app" },
		{ "<leader>os", "<cmd>Obsidian search<cr>", desc = "Search in vault " },
		{ "<leader>op", "<cmd>Obsidian quick_switch<cr>", desc = "Search for files in vault" },
		{ "<leader>ow", "<cmd>Obsidian workspace<cr>", desc = "Switch Obsidian vault" },
		{ "<leader>on", "<cmd>Obsidian new<cr>", desc = "Create new note" },
	},
	opts = {
		legacy_commands = false,
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
	},
}
