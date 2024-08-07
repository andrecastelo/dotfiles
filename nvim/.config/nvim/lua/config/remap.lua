vim.g.mapleader = " "

if not vim.g.vscode then
	local wk = require("which-key")
	wk.add({
		-- which keys
		{ "<C-h>", "<cmd> TmuxNavigateLeft<CR>", desc = "window left" },
		{ "<C-j>", "<cmd> TmuxNavigateUp<CR>", desc = "window up" },
		{ "<C-k>", "<cmd> TmuxNavigateDown<CR>", desc = "window down" },
		{ "<C-l>", "<cmd> TmuxNavigateRight<CR>", desc = "window right" },
		{ "J", "mzJ`z", desc = "move the line below to the end of the current line" },
		{ "<C-d>", "<C-d>zz" },
		{ "<C-u>", "<C-u>zz" },
		{ "n", "nzzzv" },
		{ "N", "Nzzzv" },
		{ "Q", "<nop>", desc = "no op" },
		{ "<C-f>", "<cmd>!tmux neww tmux-sessionizer<CR>", desc = "Open projects in a new session" },
		{
			"<leader>f",
			function()
				require("andrecastelo.utils").format()
			end,
			desc = "format the file",
		},
		{
			"<leader>s",
			[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
			desc = "search and replace the word under the cursor",
		},
		{ "<leader>Y", [["+Y]], desc = "copy to outside clipboard" },
		{ "<C-b>", ":NvimTreeToggle<CR>", desc = "toggle nvim-tree" },
		{ "<leader>h", ":Oil<CR>", desc = "open oil" },
		-- { "<leader>h", ":NvimTreeFindFileToggle<CR>", desc = "open the nvim tree" },

		-- change window sizes using arrow keys by pressing:
		-- UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
		{ "<S-up>", "<c-w>+", desc = "increase current pane height" },
		{ "<S-down>", "<c-w>-", desc = "decrease current pane height" },
		{ "<S-left>", "10<c-w>>", desc = "decrease current pane width" },
		{ "<S-right>", "10<c-w><", desc = "increase current pane width" },
	}, { mode = "n" })

	wk.add({
		{ "<", "<gv", desc = "Continuous visual indenting", mode = "v" },
		{ ">", ">gv", desc = "Continuous visual indenting", mode = "v" },

		-- greatest remap ever
		{ "p", [["_dP]], desc = "Pastes without removing the data from the register", mode = "x" },

		-- next greatest remap ever : asbjornHaland
		{ "<leader>y", [["+y]], desc = "Yanks to the global register", mode = { "n", "v" } },
		{ "<leader>d", [["_d]], desc = "Deletes without copying the deleted stuff", mode = { "n", "v" } },

		{ "J", ":m '>+1<CR>gv=gv", desc = "Move line down", mode = "v" },
		{ "K", ":m '<-2<CR>gv=gv", desc = "Move line up", mode = "v" },
		{ "<F1>", "<ESC>", mode = { "n", "v", "i" } },
	})
else
	vim.keymap.set("n", "J", "mzJ`z")
	vim.keymap.set("n", "n", "nzzzv")
	vim.keymap.set("n", "N", "Nzzzv")
	vim.keymap.set("n", "Q", "<nop>")

	vim.keymap.set("v", "<", "<gv")
	vim.keymap.set("v", ">", ">gv")

	vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
	vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
end
