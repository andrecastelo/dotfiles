local util = require("formatter.util")

require("formatter").setup {
    -- Enable or disable logging
    logging = true,
    -- Set the log level
    log_level = vim.log.levels.WARN,
    -- All formatter configurations are opt-in
    filetype = {
        -- Formatter configurations for filetype "lua" go here
        -- and will be executed in order
        lua = {
            -- "formatter.filetypes.lua" defines default configurations for the
            -- "lua" filetype
            require("formatter.filetypes.lua").stylua,
        },

        python = {
            function ()
                return {
                    exe = "black",
                    args = { "--line-length", "100", "-q", "-" },
                    stdin = true,
                }
            end
        },

        -- Use the special "*" filetype for defining formatter configurations on
        -- any filetype
        ["*"] = {
            require("formatter.filetypes.any").remove_trailing_whitespace
        }
    }
}
