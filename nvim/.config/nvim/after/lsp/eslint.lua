---@type vim.lsp.Config
return {
    settings = {
        workingDirectory = { mode = "auto" },
        -- No `codeActionOnSave` here: it's a VSCode-client setting the server
        -- ignores. Fix-on-save lives in the BufWritePre autocmd in
        -- lua/plugins/lsp.lua.
    },
}
