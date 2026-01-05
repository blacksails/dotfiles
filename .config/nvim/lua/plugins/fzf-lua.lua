return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-mini/mini.icons" },
	lazy = true,
	keys = {
		{ "<C-p>", "<cmd>FzfLua files<cr>", desc = "Pick files" },
		{ "<leader>ps", "<cmd>FzfLua live_grep<cr>", desc = "Grep live" },
	},
	opts = {
		winopts = {
			border = "single",
			backdrop = 100,
			title_pos = "left",
			preview = {
				border = "single",
				title_pos = "left",
			},
			row = 1,
			col = 0,
		},
	},
}
