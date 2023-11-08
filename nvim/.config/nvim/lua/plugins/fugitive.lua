return {
    "tpope/vim-fugitive",
    config = function()
        local wk = require("which-key")

        wk.register({
            ["<leader>gs"] = { vim.cmd.Git, "Open git status" },
        })
    end,
}
