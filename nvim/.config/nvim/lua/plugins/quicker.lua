return {
    'stevearc/quicker.nvim',
    enabled = not vim.g.vscode,
    event = "FileType qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
}
