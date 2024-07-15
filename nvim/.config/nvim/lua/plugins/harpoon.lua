return {
	"theprimeagen/harpoon",
	enabled = not vim.g.vscode,
	config = function()
		local wk = require("which-key")
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		wk.add({
			{ "<leader>a", mark.add_file, desc = "Add file to harpoon" },
			{ "<C-e>", ui.toggle_quick_menu, desc = "Open harpoon menu" },
			{
				"<M-h>",
				function()
					ui.nav_file(1)
				end,
				desc = "Go to harpoon entry 1",
			},
			{
				"<M-j>",
				function()
					ui.nav_file(2)
				end,
				desc = "Go to harpoon entry 2",
			},
			{
				"<M-k>",
				function()
					ui.nav_file(3)
				end,
				desc = "Go to harpoon entry 3",
			},
			{
				"<M-l>",
				function()
					ui.nav_file(4)
				end,
				desc = "Go to harpoon entry 4",
			},
			{
				"<C-b>",
				function()
					ui.nav_file(1)
				end,
				desc = "Go to harpon entry 1",
			},
			{
				"<C-n>",
				function()
					ui.nav_file(2)
				end,
				desc = "Go to harpon entry 2",
			},
			{
				"<leader>.",
				function()
					ui.nav_next()
				end,
				desc = "Go to next harpoon file",
			},
			{
				"<leader>,",
				function()
					ui.nav_prev()
				end,
				desc = "Go to previous harpoon file",
			},
		})

		require("harpoon").setup({
			menu = {
				width = vim.api.nvim_win_get_width(0) - 4,
			},
		})
	end,
}
