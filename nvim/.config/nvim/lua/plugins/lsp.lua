return {
    "VonHeikemen/lsp-zero.nvim",
    enabled = not vim.g.vscode,
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
        local cmp = require("cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').expand_snippet(args.body)
                end
            },
            sources = cmp.config.sources({
                { name = 'path' },
                { name = 'nvim_lsp' },
                { name = 'luasnip', keyword_length = 2 },
                { name = 'buffer',  keyword_length = 3 },
            }),
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<C-space>'] = cmp.mapping.complete(),
                ['<CR>'] = cmp.mapping.confirm({ select = false }),
            })
        })

        local lsp = require("lsp-zero")

        lsp.preset("recommended")
        lsp.setup()

        require('mason').setup({});

        lsp.ensure_installed({
            -- lua
            "lua_ls",

            -- front-end
            "eslint",
            "jsonls",
            "html",
            "emmet_ls",
            "tsserver",

            -- python
            "pyright",
            "ruff_lsp",

            -- golang
            "gopls",

            -- misc
            "marksman",
        })

        lsp.nvim_workspace()

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

            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
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
