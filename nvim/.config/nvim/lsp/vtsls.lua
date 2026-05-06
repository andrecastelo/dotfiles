local on_attach = require("andrecastelo.utils").on_attach

---@type vim.lsp.Config
return {
    on_attach = on_attach,
    settings = {
        vtsls = {
            experimental = {
                maxTsServerMemory = 10240,
            },
        },
        typescript = {
            preferences = {
                preferGoToSourceDefinition = true,
            },
        },
    },

}
