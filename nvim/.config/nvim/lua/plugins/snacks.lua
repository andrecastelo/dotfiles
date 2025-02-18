return {
    "folke/snacks.nvim",
    enabled = not vim.g.vscode,
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        animate = { enabled = false },
        bigfile = { enabled = true },
        explorer = { enabled = true },
        image = { enabled = true },
        indent = {
            enabled = true,
            only_scope = true,
            animate = { enabled = false }
        },
        input = { enabled = true },
        git = { enabled = true },
        notifier = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = false },
        statuscolumn = { enabled = true },
    },
}
