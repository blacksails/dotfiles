return {
	"otavioschwanck/arrow.nvim",
	dependencies = {
		{ "nvim-mini/mini.icons" },
	},
	keys = {
		{ ";", function() require("arrow").open() end, desc = "Open arrow" },
		{ "m", function() require("arrow.buffer_ui").openMenu() end, desc = "Open arrow buffer" },
	},
	opts = {
		show_icons = true,
		leader_key = ";",
		buffer_leader_key = "m",
	},
}
