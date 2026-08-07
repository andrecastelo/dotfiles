local on_attach = require("andrecastelo.utils").on_attach

---@type vim.lsp.Config
return {
    on_attach = on_attach,
    settings = {
        typescript = {
            tsserver = {
                -- NOTE: must live under `typescript.tsserver`, NOT `vtsls.experimental`.
                -- vtsls silently drops unknown keys, so a misplaced value leaves
                -- tsserver on its 3072MB default and it SIGABRTs on big monorepos.
                maxTsServerMemory = 6144,
                -- >4096 requires a real (non-Electron) node; point at it explicitly.
                nodePath = vim.fn.exepath("node"),
            },
            preferences = {
                preferGoToSourceDefinition = true,
            },
        },
    },
}
