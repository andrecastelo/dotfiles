return {
	"tpope/vim-fugitive",
	config = function()
		local wk = require("which-key")

		wk.add({
			{ "<leader>gs", vim.cmd.Git, desc = "Open git status" },
		})
	end,
}
