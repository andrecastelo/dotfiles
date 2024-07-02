vim.g.mapleader = " "

if not vim.g.vscode then
    local wk = require("which-key")
    wk.register({
        ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
        ["<C-j>"] = { "<cmd> TmuxNavigateUp<CR>", "window up" },
        ["<C-k>"] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
        ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "window right" },
        ["J"] = { "mzJ`z", "move the line below to the end of the current line" },
        ["<C-d>"] = { "<C-d>zz" },
        ["<C-u>"] = { "<C-u>zz" },
        ["n"] = { "nzzzv" },
        ["N"] = { "Nzzzv" },
        ["Q"] = { "<nop>", "no op" },
        ["<C-f>"] = { "<cmd>!tmux neww tmux-sessionizer<CR>", "Open projects in a new session" },
        ["<leader>f"] = { function()
            require('andrecastelo.utils').format()
        end, "format the file" },
        ["<leader>s"] = {
            [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
            "search and replace the word under the cursor",
        },
        ["<leader>Y"] = { [["+Y]], "copy to outside clipboard" },
        -- ["<leader>h"] = { ":Oil<CR>", "open oil" },
        ["<leader>h"] = { ":NvimTreeFindFileToggle<CR>", "open the nvim tree" },

        -- change window sizes using arrow keys by pressing:
        -- UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
        ["<S-up>"] = { "<c-w>+", "increase current pane height" },
        ["<S-down>"] = { "<c-w>-", "decrease current pane height" },
        ["<S-left>"] = { "10<c-w>>", "decrease current pane width" },
        ["<S-right>"] = { "10<c-w><", "increase current pane width" },
    }, { mode = "n" })

    wk.register({
        ["<"] = { "<gv", "Continuous visual indenting", mode = "v" },
        [">"] = { ">gv", "Continuous visual indenting", mode = "v" },

        -- greatest remap ever
        ["p"] = { [["_dP]], "Pastes without removing the data from the register", mode = "x" },

        -- next greatest remap ever : asbjornHaland
        ["<leader>y"] = { [["+y]], "Yanks to the global register", mode = { "n", "v" } },
        ["<leader>d"] = { [["_d]], "Deletes without copying the deleted stuff", mode = { "n", "v" } },

        ["J"] = { ":m '>+1<CR>gv=gv", "Move line down", mode = "v" },
        ["K"] = { ":m '<-2<CR>gv=gv", "Move line up", mode = "v" },
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
