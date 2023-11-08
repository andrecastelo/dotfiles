return {
    "theprimeagen/harpoon",
    config = function()
        local wk = require("which-key")
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        wk.register({
            ["<leader>a"] = { mark.add_file, "Add file to harpoon" },
            ["<C-e>"] = { ui.toggle_quick_menu, "Open harpoon menu" },

            ["<C-b>"] = {
                function()
                    ui.nav_file(1)
                end,
                "Go to harpon entry 1",
            },
            ["<C-n>"] = {
                function()
                    ui.nav_file(2)
                end,
                "Go to harpon entry 2",
            },
            ["<leader>."] = {
                function()
                    ui.nav_next()
                end,
                "Go to next harpoon file",
            },
            ["<leader>,"] = {
                function()
                    ui.nav_prev()
                end,
                "Go to previous harpoon file",
            },
        })
    end,
}
