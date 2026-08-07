return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    enabled = not vim.g.vscode,
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
        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "✘",
                    [vim.diagnostic.severity.WARN] = "▲",
                    [vim.diagnostic.severity.HINT] = "⚑",
                    [vim.diagnostic.severity.INFO] = "",
                },
            },
            float = {
                border = "rounded",
                header = "",
                prefix = "",
                source = true,
                style = "minimal",
            },
            jump = {
                on_jump = function(_, bufnr)
                    vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false })
                end,
            }
        })

        require("mason").setup()
        require("mason-lspconfig").setup()
        require("mason-tool-installer").setup({
            ensure_installed = {
                -- lua
                "lua_ls",

                -- front-end
                "jsonls",
                "vtsls",
                -- "ts_ls",
                "html",
                "emmet_ls",
                "tailwindcss",
                "eslint",

                -- python
                "pyright",

                -- golang
                "gopls",

                -- misc
                "marksman",
                "astro"
            },
        })

        local base_on_attach = vim.lsp.config.eslint.on_attach
        vim.lsp.config("eslint", {
            on_attach = function(client, bufnr)
                if not base_on_attach then return end

                base_on_attach(client, bufnr)
                -- Redundant: `codeActionOnSave.mode = "all"` in after/lsp/eslint.lua
                -- already fixes on save, so this ran ESLint twice per write.
                -- vim.api.nvim_create_autocmd("BufWritePre", {
                --     buffer = bufnr,
                --     command = "LspEslintFixAll",
                -- })
            end,
        })

        -- vim.api.nvim_create_autocmd("LspAttach", {
        --     callback = function(args)
        --         local client = vim.lsp.get_client_by_id(args.data.client_id)
        --         if not client then
        --             return
        --         end
        --
        --         if client.name == "eslint" then
        --             vim.api.nvim_create_autocmd("BufWritePre", {
        --                 buffer = args.buf,
        --                 command = "LspEslintFixAll",
        --             })
        --         end
        --     end,
        -- })


        local cmp = require("cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            sources = cmp.config.sources({
                { name = "luasnip", keyword_length = 2 },
                { name = "path" },
                { name = "nvim_lsp" },
                { name = "buffer",  keyword_length = 3 },
            }),
            mapping = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-m>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-k>"] = cmp.mapping.confirm({ select = true }),
                ["<C-space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
            }),
        })
    end,
}
