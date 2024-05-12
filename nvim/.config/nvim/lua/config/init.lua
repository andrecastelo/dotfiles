require("config.remap")
require("config.set")

if not vim.g.vscode then
    vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
    pattern = "*",
    command = "normal zR",
    })

    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = "*",
    command = "lua vim.lsp.buf.format({ async = true })",
    })
end
