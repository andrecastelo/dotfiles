return {
    "nvimtools/none-ls.nvim",
    enabled = not vim.g.vscode,
    config = function()
        -- https://github.com/nvimtools/none-ls.nvim
        local diagnostics_format = "[#{c}] #{m} (#{s})"
        local null_ls = require("null-ls")
        local formatting = null_ls.builtins.formatting
        local diagnostics = null_ls.builtins.diagnostics

        null_ls.setup({
            sources = {
                -- javascript/typescript
                formatting.prettier.with({
                    prefer_local = "node_modules/.bin",
                }),

                -- golang
                formatting.gofmt,

                -- just file
                formatting.just,

                -- lua
                formatting.stylua.with({
                    condition = function(utils)
                        return utils.root_has_file({ "stylua.toml", ".stylua.toml" })
                    end,
                }),

                -- yaml
                diagnostics.yamllint.with({
                    diagnostics_format = diagnostics_format,
                    extra_args = function(params)
                        return {
                            "-d",
                            string.format(
                                "{extends: default, rules: {line-length: {max: %d}}}",
                                vim.opt_local.textwidth:get() + 1
                            ),
                        }
                    end,
                }),
                formatting.yamlfix.with({
                    env = function(params)
                        return {
                            -- YAMLFIX_LINE_LENGTH = tostring(vim.opt_local.textwidth:get() + 1),
                            YAMLFIX_SECTION_WHITELINES = "1",
                            YAMLFIX_quote_representation = '"',
                            YAMLFIX_SEQUENCE_STYLE = "block_style",
                        }
                    end,
                }),

                -- markdown
                diagnostics.markdownlint.with({
                    diagnostics_format = diagnostics_format,
                }),

                formatting.markdownlint,
            }
        })
    end,
}
