return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v1.x",
    dependencies = {
        -- LSP Support
        { "neovim/nvim-lspconfig" },
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },

        -- Autocompletion
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "saadparwaiz1/cmp_luasnip" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-nvim-lua" },

        -- Snippets
        { "L3MON4D3/LuaSnip" },
        { "rafamadriz/friendly-snippets" },
    },
    config = function()
        local lsp = require("lsp-zero")

        lsp.preset("recommended")
        lsp.setup()

        lsp.ensure_installed({
            -- lua
            "lua_ls",

            -- front-end
            "tsserver",
            "eslint",
            "jsonls",
            "html",
            "emmet_ls",

            -- python
            "pyright",
            "ruff_lsp",

            -- golang
            "gopls",

            -- misc
            "marksman",
        })

        lsp.nvim_workspace()

        local cmp = require("cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_mappings = lsp.defaults.cmp_mappings({
            ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
            ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
            ["<C-y>"] = cmp.mapping.confirm({ select = true }),
            ["<C-space>"] = cmp.mapping.complete(),
        })

        cmp_mappings["<Tab>"] = nil
        cmp_mappings["<S-Tab>"] = nil

        lsp.set_preferences({
            suggest_lsp_servers = false,
            sign_icons = {
                error = "E",
                warn = "W",
                hint = "H",
                info = "I",
            },
        })

        lsp.on_attach(function(client, bufnr)
            local opts = { buffer = bufnr, remap = false, noremap = true }

            vim.keymap.set("n", "gd", function()
                vim.lsp.buf.definition()
            end, opts)
            vim.keymap.set("n", "gD", function()
                vim.lsp.buf.declaration()
            end, opts)
            vim.keymap.set("n", "K", function()
                vim.lsp.buf.hover()
            end, opts)
            vim.keymap.set("n", "<leader>vws", function()
                vim.lsp.buf.workspace_symbol()
            end, opts)
            vim.keymap.set("n", "<leader>vd", function()
                vim.diagnostic.open_float()
            end, opts)
            vim.keymap.set("n", "[d", function()
                vim.diagnostic.goto_next()
            end, opts)
            vim.keymap.set("n", "]d", function()
                vim.diagnostic.goto_prev()
            end, opts)
            vim.keymap.set("n", "<leader>vca", function()
                vim.lsp.buf.code_action()
            end, opts)
            vim.keymap.set("n", "<leader>vrr", function()
                vim.lsp.buf.references()
            end, opts)
            vim.keymap.set("n", "<leader>vrn", function()
                vim.lsp.buf.rename()
            end, opts)

            vim.keymap.set("i", "<C-h>", function()
                vim.lsp.buf.signature_help()
            end, opts)

            -- wk.register({
            --     ["gd"] = {
            --         function()
            --             vim.lsp.buf.definition()
            --         end,
            --         "Go to definition",
            --     },
            --     ["K"] = {
            --         function()
            --             vim.lsp.buf.hover()
            --         end,
            --     },
            --     ["<leader>vws"] = {
            --         function()
            --             vim.lsp.buf.workspace_symbol()
            --         end,
            --     },
            --     ["<leader>vd"] = {
            --         function()
            --             vim.diagnostic.open_float()
            --         end,
            --     },
            --     ["[d"] = {
            --         function()
            --             vim.diagnostic.goto_next()
            --         end,
            --         "Go to the next diagnostic entry",
            --     },
            --     ["]d"] = {
            --         function()
            --             vim.diagnostic.goto_prev()
            --         end,
            --         "Go to the previous diagnostic entry",
            --     },
            --     ["<leader>vca"] = {
            --         function()
            --             vim.lsp.buf.code_action()
            --         end,
            --         "Open code actions",
            --     },
            --     ["<leader>vrr"] = {
            --         function()
            --             vim.lsp.buf.references()
            --         end,
            --         "View references"
            --     },
            --     ["<leader>vrn"] = {
            --         function()
            --             vim.lsp.buf.rename()
            --         end,
            --         "Rename through treesitter"
            --     },
            -- }, { remap = false, noremap = false })
        end)

        lsp.setup()

        vim.diagnostic.config({
            virtual_text = true,
        })

        local lspconfig = require("lspconfig")
        lspconfig.lua_ls.setup({
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = "LuaJIT",
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { "vim" },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = {
                        enable = false,
                    },
                },
            },
        })


        local capabilities = vim.lsp.protocol.make_client_capabilities()

        lspconfig.emmet_ls.setup({
            filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte",
                "pug", "typescriptreact", "vue" },
            capabilities = capabilities,
        })
    end,
}
