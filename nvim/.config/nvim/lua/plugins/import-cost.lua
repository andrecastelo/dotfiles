return {
    'barrett-ruth/import-cost.nvim',
    enabled = not vim.g.vscode,
    build = 'sh install.sh yarn',
    -- if on windows
    -- build = 'pwsh install.ps1 yarn',
    config = true
}
