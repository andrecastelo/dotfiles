return {
    "mfussenegger/nvim-lint",
    enabled = false,
    config = function()
        local lint = require('lint')

        lint.linters_by_ft = {
            javascript = { "eslint" },
            typescript = { "eslint" },
            javascriptreact = { "eslint" },
            typescriptreact = { "eslint" },
            svelte = { "eslint" },
        }

        vim.api.nvim_create_autocmd({ "BufWritePost", "BufWritePre" }, {
            callback = function()
                lint.try_lint()
            end,
        })
    end
}
