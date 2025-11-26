---@type vim.lsp.Config
return {
    settings = {
        workingDirectory = { mode = "auto" },
        codeActionOnSave = {
            enable = true,
            mode = "all",
        }
    },
}
