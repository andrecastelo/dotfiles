local on_attach = require("andrecastelo.utils").on_attach

-- vue_ls (formerly `volar`) does not resolve TypeScript itself. In hybrid mode it
-- forwards every tsserver query over a custom `tsserver/request` notification and
-- waits for a `tsserver/response` back. Nothing wires that up for us outside of
-- VS Code, so we proxy it to vtsls by hand — without this handler you get template
-- highlighting and nothing else: no go-to-definition, no prop types, no completion.

---@type vim.lsp.Config
return {
    on_attach = on_attach,
    on_init = function(client)
        client.handlers["tsserver/request"] = function(_, result, context)
            local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
            if #clients == 0 then
                vim.notify(
                    "vtsls is not attached to this buffer; vue_ls cannot resolve TypeScript without it.",
                    vim.log.levels.ERROR
                )
                return
            end

            local ts_client = clients[1]
            local id, command, payload = unpack(result[1])

            ts_client:exec_cmd({
                title = "vue_request_forward",
                command = "typescript.tsserverRequest",
                arguments = { command, payload },
            }, { bufnr = context.bufnr }, function(_, response)
                ---@diagnostic disable-next-line: param-type-mismatch
                client:notify("tsserver/response", { { id, response.body } })
            end)
        end
    end,
}
