local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>pf", function()
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
vim.keymap.set("n", "<leader>ps", function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set("n", "<leader>pr", builtin.live_grep)
vim.keymap.set("n", "<leader>b", function()
    builtin.buffers({ show_all_buffers = true })
end)

vim.keymap.set("n", "<leader>fc", builtin.colorscheme)
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

local telescope = require("telescope")

telescope.setup({
    pickers = {
        find_files = {
            hidden = true,
        },
    },
})
