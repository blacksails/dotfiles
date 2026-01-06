local function config()
	-- Dotfiles toggle
	local show_dotfiles = true
	local filter = function(fs_entry)
		if show_dotfiles then
			return true
		end
		return not vim.startswith(fs_entry.name, ".")
	end
	local toggle_dotfiles = function()
		show_dotfiles = not show_dotfiles
		MiniFiles.refresh({ content = { filter = filter } })
	end

	require("mini.files").setup({
		-- Customization of shown content
		content = {
			-- Predicate for which file system entries to show
			filter = filter,
			-- What prefix to show to the left of file system entry
			prefix = nil,
			-- In which order to show file system entries
			sort = nil,
		},

		-- Module mappings created only inside explorer.
		-- Use `''` (empty string) to not create one.
		mappings = {
			close = "q",
			go_in = "",
			go_in_plus = "l",
			go_out = "h",
			go_out_plus = "H",
			mark_goto = "'",
			mark_set = "m",
			reset = "<BS>",
			reveal_cwd = "@",
			show_help = "g?",
			synchronize = "=",
			trim_left = "<",
			trim_right = ">",
		},

		-- General options
		options = {
			-- Whether to delete permanently or move into module-specific trash
			permanent_delete = true,
			-- Whether to use for editing directories
			use_as_default_explorer = true,
		},

		-- Customization of explorer windows
		windows = {
			-- Maximum number of windows to show side by side
			max_number = math.huge,
			-- Whether to show preview of file/directory under cursor
			preview = true,
			-- Width of focused window
			width_focus = 50,
			-- Width of non-focused window
			width_nofocus = 15,
			-- Width of preview window
			width_preview = 80,
		},
	})
	local map_split = function(buf_id, lhs, direction)
		local rhs = function()
			-- Make new window and set it as target
			local cur_target = MiniFiles.get_explorer_state().target_window
			local new_target = vim.api.nvim_win_call(cur_target, function()
				vim.cmd(direction .. " split")
				return vim.api.nvim_get_current_win()
			end)

			MiniFiles.set_target_window(new_target)

			-- This intentionally doesn't act on file under cursor in favor of
			-- explicit "go in" action (`l` / `L`). To immediately open file,
			-- add appropriate `MiniFiles.go_in()` call instead of this comment.
		end

		-- Adding `desc` will result into `show_help` entries
		local desc = "Split " .. direction
		vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
	end

	vim.api.nvim_create_autocmd("User", {
		pattern = "MiniFilesBufferCreate",
		callback = function(args)
			local buf_id = args.data.buf_id
			-- Tweak keys to your liking
			map_split(buf_id, "<C-s>", "belowright horizontal")
			map_split(buf_id, "<C-v>", "belowright vertical")
			map_split(buf_id, "<C-t>", "tab")
			vim.keymap.set("n", "<C-.>", toggle_dotfiles, { buffer = buf_id, desc = "Toggle dotfiles" })
		end,
	})
end

return {
	"nvim-mini/mini.files",
	version = false,
	dependencies = { "nvim-mini/mini.icons" },
	config = config,
	lazy = true,
	keys = {
		{
			"<leader>pV",
			function()
				require("mini.files").open()
			end,
			desc = "Open Mini Files at cwd",
		},
		{
			"<leader>pv",
			function()
				require("mini.files").open(vim.api.nvim_buf_get_name(0))
			end,
			desc = "Open Mini Files at current file",
		},
	},
}
