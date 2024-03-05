return {
    {
        "christoomey/vim-tmux-navigator",
        event = "VimEnter",
    },
    {
        "folke/tokyonight.nvim",
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
        "glepnir/dashboard-nvim",
        event = "VimEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    { "IndianBoy42/tree-sitter-just" },
    { "lewis6991/gitsigns.nvim" },
    { "mbbill/undotree" },
    { "numToStr/Comment.nvim" },
    { "nvim-treesitter/playground" },
    {
        "nvim-treesitter/nvim-treesitter-context",
        enabled = false,
        config = function()
            require("treesitter-context").setup({
                multiline_threshold = 1,
            })
        end
    },
    {
        "nvim-tree/nvim-web-devicons",
        -- config = function()
        --     require('nvim-web-devicons').setup({
        --         override = {
        --             toml = {
        --                 icon = "",
        --                 color = "#6d8086",
        --                 cterm_color = "66",
        --             }
        --         }
        --     })
        -- end
    },
    { "rose-pine/neovim",  as = "rose-pine" },
    { "tpope/vim-fugitive" },
    { "tpope/vim-rhubarb" },
    -- {
    --     "windwp/nvim-autopairs",
    --     event = "InsertEnter",
    --     opts = {},
    -- },
}
