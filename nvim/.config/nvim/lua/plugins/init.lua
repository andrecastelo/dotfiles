return {
    { "christoomey/vim-tmux-navigator", event = "VimEnter", enabled = not vim.g.vscode },
    {
        "echasnovski/mini.pairs",
        enabled = not vim.g.vscode,
        version = "*",
        config = function()
            require("mini.pairs").setup()
        end,
    },
    {
        "echasnovski/mini.surround",
        enabled = not vim.g.vscode,
        version = "*",
        config = function()
            require("mini.surround").setup()
        end,
    },
    {
        "folke/tokyonight.nvim",
        enabled = not vim.g.vscode,
        config = function()
            require("tokyonight").setup({
                style = "night",
                styles = {
                    comments = { bold = false },
                    keywords = { bold = false },
                    functions = { bold = false },
                    variables = { bold = false },
                },
                on_highlights = function(highlights, colors)
                    highlights.Title.bold = false
                end,
            })
            vim.cmd.colorscheme("tokyonight")
        end,
    },
    {
        "folke/trouble.nvim",
        enabled = not vim.g.vscode,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        config = function()
            local trouble = require("trouble")
            vim.keymap.set("n", "<leader>xx", function()
                trouble.toggle()
            end)
            vim.keymap.set("n", "<leader>xw", function()
                trouble.toggle("workspace_diagnostics")
            end)
            vim.keymap.set("n", "<leader>xd", function()
                trouble.toggle("document_diagnostics")
            end)
            vim.keymap.set("n", "<leader>xq", function()
                trouble.toggle("quickfix")
            end)
            vim.keymap.set("n", "<leader>xl", function()
                trouble.toggle("loclist")
            end)
            vim.keymap.set("n", "gR", function()
                trouble.toggle("lsp_references")
            end)
        end,
    },
    {
        "folke/which-key.nvim",
        enabled = not vim.g.vscode,
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
            require("which-key").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
        end,
    },
    {
        "IndianBoy42/tree-sitter-just",
        enabled = not vim.g.vscode,
    },
    {
        "lewis6991/gitsigns.nvim",
        enabled = not vim.g.vscode,
    },
    {
        "mbbill/undotree",
        enabled = not vim.g.vscode,
    },
    {
        "nvim-treesitter/playground",
        enabled = not vim.g.vscode,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        enabled = not vim.g.vscode,
        config = function()
            require("treesitter-context").setup({
                multiline_threshold = 2,
            })
        end,
    },
    {
        "nvim-tree/nvim-web-devicons",
        enabled = not vim.g.vscode,
    },
    {
        "rose-pine/neovim",
        enabled = not vim.g.vscode,
        as = "rose-pine",
    },
    {
        "tpope/vim-fugitive",
        enabled = not vim.g.vscode,
    },
    {
        "tpope/vim-rhubarb",
        enabled = not vim.g.vscode,
    },
}
