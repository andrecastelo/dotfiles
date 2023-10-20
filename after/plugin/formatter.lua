local util = require("formatter.util")

require("formatter").setup({
    -- Enable or disable logging
    logging = true,
    -- Set the log level
    log_level = vim.log.levels.WARN,
    -- All formatter configurations are opt-in
    filetype = {
        lua = {
            require("formatter.filetypes.lua").stylua,
        },

        python = {
            function()
                return {
                    exe = "black",
                    args = { "--line-length", "100", "-q", "-" },
                    stdin = true,
                }
            end,

            function()
                return {
                    exe = "isort",
                    args = { "--profile", "black", "--line-length", "100", "-q", "-" },
                    stdin = true,
                }
            end,
        },

        typescript = {
            require("formatter.filetypes.typescript").prettier,
            require("formatter.filetypes.typescript").eslint,
        },

        typescriptreact = {
            require("formatter.filetypes.typescriptreact").prettier,
            require("formatter.filetypes.typescriptreact").eslint,
        },

        javascript = {
            require("formatter.filetypes.javascript").prettier,
            require("formatter.filetypes.javascript").eslint,
        },

        javascriptreact = {
            require("formatter.filetypes.javascriptreact").prettier,
            require("formatter.filetypes.javascriptreact").eslint,
        },

        markdown = {
            require("formatter.filetypes.markdown").prettier,
        }

        -- Use the special "*" filetype for defining formatter configurations on
        -- any filetype
        -- ["*"] = {
        --     require("formatter.filetypes.any").remove_trailing_whitespace,
        -- },
    },
})
