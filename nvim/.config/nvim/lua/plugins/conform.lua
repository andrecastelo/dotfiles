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
            formatters_by_ft = {
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                svelte = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                graphql = { "prettier" },

                lua = { "stylua" },

                python = { "ruff_organize_imports", "ruff_format" },

                go = { "goimports", "gofmt" },
            },
        })

        vim.api.nvim_create_user_command(
            "Format",
            require('andrecastelo.utils').format,
            { range = true }
        )
    end
}
