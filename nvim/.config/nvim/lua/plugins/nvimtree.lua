local function my_on_attach(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
        return {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
        }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
    vim.keymap.set("n", "<leader>r", api.tree.change_root_to_node, opts("Change root to node"))

    -- remove some defaults
    vim.keymap.del("n", "<Tab>", { buffer = bufnr })
    vim.keymap.del("n", "<C-e>", { buffer = bufnr })
end

return {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons", -- optional
    },
    config = function()
        -- pass to setup along with your other options
        require("nvim-tree").setup({
            on_attach = my_on_attach,
            hijack_cursor = true,
            diagnostics = {
                enable = true,
                show_on_dirs = true,
                show_on_open_dirs = false,
                severity = {
                    min = vim.diagnostic.severity.INFO,
                    max = vim.diagnostic.severity.ERROR,
                },
            },
            filters = {
                custom = {
                    "^.git$",
                    "^node_modules",
                    ".DS_Store",
                },
            },
            git = {
                ignore = false,
            },
        })
    end,
}
