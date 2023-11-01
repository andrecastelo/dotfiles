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
    tag = "0.1.3",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    config = function()
        local builtin = require("telescope.builtin")

        vim.keymap.set("n", "<leader><space>", function()
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
        end)
        vim.keymap.set("n", "<C-p>", builtin.git_files, {})
        vim.keymap.set("n", "<C-S-f>", function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set("v", "<leader>gs", function()
            local text = vim.getVisualSelection()
            builtin.grep_string({ default_text = text })
        end)

        vim.keymap.set("n", "<leader>/", builtin.live_grep)
        vim.keymap.set("v", "<leader>gr", function()
            local text = vim.getVisualSelection()
            builtin.live_grep({ default_text = text })
        end)

        vim.keymap.set("n", "<leader>b", function()
            builtin.buffers({ show_all_buffers = true })
        end)

        vim.keymap.set("n", "<leader>[c", builtin.colorscheme)
        vim.keymap.set("n", "<leader>[h", builtin.help_tags, {})

        local telescope = require("telescope")

        telescope.setup({
            pickers = {
                find_files = {
                    hidden = true,
                },
            },
        })
    end,
}
