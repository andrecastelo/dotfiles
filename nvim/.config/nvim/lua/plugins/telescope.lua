function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ""
	end
end

return {
	"nvim-telescope/telescope.nvim",
	enabled = not vim.g.vscode,
	tag = "0.1.3",
	dependencies = { { "nvim-lua/plenary.nvim" } },
	config = function()
		local builtin = require("telescope.builtin")
		local wk = require("which-key")

		wk.add({
			{
				"<leader><space>",
				function()
					builtin.find_files({
						find_command = {
							"rg",
							"--files",
							"-u",
							"-g",
							"!.git",
							"-g",
							"!node_modules",
							"-g",
							"!venv",
							"-g",
							"!*.pyc",
						},
					})
				end,
				desc = "search all files",
				mode = "n",
			},
			{ "<C-p>", builtin.git_files, desc = "Find files in the git repo" },
			{ "<M-p>", builtin.git_files, desc = "Find files in the git repo" },
			{ "<leader>/", builtin.live_grep, desc = "Live grep against all files" },
			{ "<leader>]c", builtin.colorscheme, desc = "Open list of colorschemes" },
			{ "<leader>]h", builtin.help_tags, desc = "View help tags" },
			{
				"<leader>]/",
				function()
					builtin.grep_string({ search = vim.fn.input("Grep > ") })
				end,
				desc = "Grep string, but telescope for file names",
			},
			{
				"<leader>b",
				function()
					builtin.buffers({
						show_all_buffers = false,
						sort_mru = true,
					})
				end,
				desc = "Search buffers",
			},
			{ "<leader>m", "<cmd>Telescope marks<CR>", desc = "Telescope marks" },
			{
				"<leader>]/",
				function()
					local text = vim.getVisualSelection()
					require("telescope.builtin").grep_string({ default_text = text })
				end,
				desc = "Grep selected text",
				mode = "v",
			},
			{
				"<leader>/",
				function()
					local text = vim.getVisualSelection()
					require("telescope.builtin").live_grep({ default_text = text })
				end,
				desc = "Live grep selected text against all files",
				mode = "v",
			},
		})

		local telescope = require("telescope")

		telescope.setup({
			defaults = {
				layout_strategy = "vertical",
				layout_config = {
					width = 0.95,
					height = 0.95,
					preview_cutoff = 10,
					prompt_position = "top",
					mirror = true,
				},
				mappings = {
					i = {
						["<C-s>"] = require("andrecastelo.harpoon").mark_file,
						["<C-h>"] = require("telescope.actions").cycle_history_prev,
						["<C-l>"] = require("telescope.actions").cycle_history_next,
					},
					n = {
						["<C-s>"] = require("andrecastelo.harpoon").mark_file,
					},
				},
			},
			pickers = {
				find_files = {
					hidden = true,
				},
			},
		})
	end,
}
