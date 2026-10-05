local on_attach = require("andrecastelo.utils").on_attach

-- Vue Language Tools 3.x is hybrid-mode only: vue_ls handles the SFC/template,
-- but every TypeScript question is answered by tsserver with @vue/typescript-plugin
-- loaded. That plugin ships inside the mason vue-language-server package.
local vue_plugin_path = vim.fn.stdpath("data")
    .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

---@type vim.lsp.Config
return {
    on_attach = on_attach,
    -- `vue` is required here. Without it vtsls never attaches to .vue buffers,
    -- the plugin below never loads, and vue_ls silently returns no type info.
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "vue",
    },
    settings = {
        vtsls = {
            tsserver = {
                globalPlugins = {
                    {
                        name = "@vue/typescript-plugin",
                        location = vue_plugin_path,
                        languages = { "vue" },
                        configNamespace = "typescript",
                        enableForWorkspaceTypeScriptVersions = true,
                    },
                },
            },
        },
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
