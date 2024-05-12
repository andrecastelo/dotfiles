return {
    'JoosepAlviste/nvim-ts-context-commentstring',
    enabled = not vim.g.vscode,
    config = function()
        require('ts_context_commentstring').setup({
            enable_autocmd = false,
        })
    end
}
