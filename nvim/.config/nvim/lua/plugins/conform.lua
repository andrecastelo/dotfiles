return {
    'stevearc/conform.nvim',
    enabled = not vim.g.vscode,
    opts = {},
    config = function()
        local conform = require('conform');

        conform.setup({
            format_on_save = {
                timeout_ms = 500,
                lsp_format = 'fallback',
            },
        })

        vim.api.nvim_create_user_command("Format", require('andrecastelo.utils').format, { range = true })
    end
}
