vim.g.mapleader = " "

local cn_function = function()
    -- Get the visual selection
    ---@diagnostic disable-next-line: deprecated
    local _, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
    ---@diagnostic disable-next-line: deprecated
    local _, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))

    -- Neovim uses 1-based indexing for rows, adjust for Lua (0-based)
    csrow = csrow - 1
    cerow = cerow - 1

    -- Get the lines of the selection
    local lines = vim.api.nvim_buf_get_lines(0, csrow, cerow + 1, false)

    -- Handle single vs multi-line selection
    if #lines == 1 then
        lines[1] = lines[1]:sub(1, cscol - 1) ..
            "{cn(" .. lines[1]:sub(cscol, cecol) .. ")}" ..
            lines[1]:sub(cecol + 1)
    else
        -- First line
        lines[1] = lines[1]:sub(1, cscol - 1) .. "{cn(" .. lines[1]:sub(cscol)
        -- Last line
        lines[#lines] = lines[#lines]:sub(1, cecol) .. ")}" .. lines[#lines]:sub(cecol + 1)
    end

    -- Replace the selected text with the modified version
    vim.api.nvim_buf_set_lines(0, csrow, cerow + 1, false, lines)
end

if not vim.g.vscode then
    local wk = require("which-key")
    wk.add({
        -- which keys
        { "<C-h>", "<cmd> TmuxNavigateLeft<CR>",           desc = "window left" },
        { "<C-j>", "<cmd> TmuxNavigateUp<CR>",             desc = "window up" },
        { "<C-k>", "<cmd> TmuxNavigateDown<CR>",           desc = "window down" },
        { "<C-l>", "<cmd> TmuxNavigateRight<CR>",          desc = "window right" },
        { "J",     "mzJ`z",                                desc = "move the line below to the end of the current line" },
        { "<C-d>", "<C-d>zz" },
        { "<C-u>", "<C-u>zz" },
        { "n",     "nzzzv" },
        { "N",     "Nzzzv" },
        { "Q",     "<nop>",                                desc = "no op" },
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
        { "<leader>Y", [["+Y]],    desc = "copy to outside clipboard" },
        { "<leader>h", ":Oil<CR>", desc = "open oil" },
        { "<leader>j", ":Jsonpath<CR>", desc = "copy JSON path at cursor" },

        -- change window sizes using arrow keys by pressing:
        -- UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
        { "<S-up>",    "<c-w>+",   desc = "increase current pane height" },
        { "<S-down>",  "<c-w>-",   desc = "decrease current pane height" },
        { "<S-right>", "10<c-w>>", desc = "decrease current pane width" },
        { "<S-left>",  "10<c-w><", desc = "increase current pane width" },
    }, { mode = "n" })

    wk.add({
        { "<",         "<gv",              desc = "Continuous visual indenting",                        mode = "v" },
        { ">",         ">gv",              desc = "Continuous visual indenting",                        mode = "v" },

        -- greatest remap ever
        { "p",         [["_dP]],           desc = "Pastes without removing the data from the register", mode = "x" },

        -- next greatest remap ever : asbjornHaland
        { "<leader>y", [["+y]],            desc = "Yanks to the global register",                       mode = { "n", "v" } },
        { "<leader>d", [["_d]],            desc = "Deletes without copying the deleted stuff",          mode = { "n", "v" } },

        { "J",         ":m '>+1<CR>gv=gv", desc = "Move line down",                                     mode = "v" },
        { "K",         ":m '<-2<CR>gv=gv", desc = "Move line up",                                       mode = "v" },
        { "<F1>",      "<ESC>",            mode = { "n", "v", "i" } },
        { "jj",        "<ESC>",            mode = { "i" } },
        { "jk",        "<ESC>",            mode = { "i" } },
    })

    vim.api.nvim_create_user_command(
        "Cn",
        cn_function,
        { range = true, desc = "Wrap visual selection in {cn(...)}" }
    )

    vim.api.nvim_create_user_command("Jsonpath", function()
        local node = vim.treesitter.get_node()
        if not node then
            vim.notify("No treesitter node at cursor", vim.log.levels.WARN)
            return
        end
        local parts = {}
        while node do
            if node:type() == "pair" then
                local key = node:field("key")[1]
                if key then
                    local text = vim.treesitter.get_node_text(key, 0)
                    table.insert(parts, 1, (text:gsub('^"(.*)"$', "%1")))
                end
            elseif node:type() == "array" then
                -- find index of the child containing cursor
                local child = node:named_child(0)
                local i = 0
                while child do
                    if vim.treesitter.is_ancestor(child, vim.treesitter.get_node()) or child == vim.treesitter.get_node() then
                        table.insert(parts, 1, "[" .. i .. "]")
                        break
                    end
                    i = i + 1
                    child = node:named_child(i)
                end
            end
            node = node:parent()
        end
        local path = table.concat(parts, "."):gsub("%.%[", "[")
        vim.fn.setreg("+", path)
        vim.notify(path)
    end, { desc = "Copy JSON path at cursor to clipboard" })

    vim.api.nvim_create_user_command("Path", function()
        local path = vim.fn.expand("%:.")
        vim.fn.setreg("+", path)
        vim.notify(path)
    end, { desc = "Copy absolute path of current file to clipboard" })
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
