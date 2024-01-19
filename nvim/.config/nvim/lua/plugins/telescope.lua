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
        local wk = require("which-key")

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

        wk.register({
            ["<C-p>"] = { builtin.git_files, "Find files in the git repo" },
            ["<M-p>"] = { builtin.git_files, "Find files in the git repo" },
            ["<leader>/"] = { builtin.live_grep, "Live grep against all files" },
            ["<leader>]c"] = { builtin.colorscheme, "Open list of colorschemes" },
            ["<leader>]h"] = { builtin.help_tags, "View help tags" },
            ["<leader>]/"] = {
                function()
                    builtin.grep_string({ search = vim.fn.input("Grep > ") })
                end,
                "Grep string, but telescope for file names",
            },
            ["<leader>b"] = {
                function()
                    builtin.buffers({
                        show_all_buffers = false,
                        sort_mru = true,
                    })
                end,
                "Search buffers",
            },
            ["<leader>m"] = { "<cmd>Telescope marks<CR>", "Telescope marks" },
        })

        wk.register({
            ["<leader>]/"] = {
                function()
                    local text = vim.getVisualSelection()
                    require("telescope.builtin").grep_string({ default_text = text })
                end,
                "Grep selected text",
            },
            ["<leader>/"] = {
                function()
                    local text = vim.getVisualSelection()
                    require("telescope.builtin").live_grep({ default_text = text })
                end,
                "Live grep selected text against all files",
            },
        }, { mode = "v" })

        -- vim.keymap.set("v", "<leader>gs", function()
        --     local text = vim.getVisualSelection()
        --     require("telescope.builtin").grep_string({ default_text = text })
        -- end)

        vim.keymap.set("v", "<leader>gr", function()
            local text = vim.getVisualSelection()
            require("telescope.builtin").live_grep({ default_text = text })
        end)

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
