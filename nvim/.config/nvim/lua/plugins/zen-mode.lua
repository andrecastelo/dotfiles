return {
    "folke/zen-mode.nvim",
    config = function()
        local wk = require("which-key")
        local zenMode = require('zen-mode')

        zenMode.setup({
            window = {
                backdrop = 0.90,
                options = {
                    foldcolumn = "0",
                    signcolumn = "no",
                }
            }
        })

        wk.register({
            ["<leader>zz"] = {
                function()
                    zenMode.toggle()
                end,
                "Toggle Zen Mode"
            },
        })
    end
}
