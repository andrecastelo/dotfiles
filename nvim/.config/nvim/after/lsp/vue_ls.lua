local on_attach = require("andrecastelo.utils").on_attach

-- vue_ls (formerly `volar`) does not resolve TypeScript itself. In hybrid mode it
-- forwards every tsserver query over a custom `tsserver/request` notification and
-- waits for a `tsserver/response` back. nvim-lspconfig's own `lsp/vue_ls.lua`
-- wires that proxy up (and retries while vtsls is still starting), so all we add
-- here is our keymaps. The other half of the setup is `filetypes` in
-- after/lsp/vtsls.lua -- without `vue` there, vtsls never attaches to a .vue
-- buffer and vue_ls errors out with "Could not find ts_ls, vtsls, or
-- typescript-tools lsp client".
--
-- NOTE: this must live in after/lsp/, not lsp/. Neovim merges every lsp/<name>.lua
-- on the runtimepath with last-one-wins, and lazy.nvim puts plugin dirs after
-- ~/.config/nvim -- so nvim-lspconfig would silently clobber this file.

---@type vim.lsp.Config
return {
    on_attach = on_attach,
}
