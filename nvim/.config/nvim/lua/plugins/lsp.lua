local augroup_formatting = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false, noremap = true }

    vim.keymap.set("n", "gd", function()
        vim.lsp.buf.definition()
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
end

return {
    "VonHeikemen/lsp-zero.nvim",
    enabled = not vim.g.vscode,
    branch = "v4.x",
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
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        lsp.extend_lspconfig({
            capabilities = capabilities,
            lsp_attach = on_attach,
            float_border = "rounded",
            sign_text = {
                error = "✘",
                warn = "▲",
                hint = "⚑",
                info = "",
            },
        })

        vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")

        vim.diagnostic.config({
            virtual_text = false,
            severity_sort = true,
            float = {
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })

        local lspconfig = require("lspconfig")

        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = {
                -- lua
                "lua_ls",

                -- front-end
                "jsonls",
                "vtsls",
                "html",
                "emmet_ls",
                "tailwindcss",
                "eslint",

                -- python
                "pyright",
                "ruff_lsp",

                -- golang
                "gopls",

                -- misc
                "marksman",
            },
        })

        lspconfig.lua_ls.setup({
            on_init = function(client)
                lsp.nvim_lua_settings(client, {})
            end,
            on_attach = on_attach,
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

        lspconfig.eslint.setup({
            root_dir = lspconfig.util.root_pattern(
                '.eslintrc',
                '.eslintrc.js',
                '.eslintrc.cjs',
                '.eslintrc.yaml',
                '.eslintrc.yml',
                '.eslintrc.json',
                'eslint.config.js'
            -- Disabled to prevent "No ESLint configuration found" exceptions
            -- 'package.json',
            ),

            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    command = "EslintFixAll",
                })
            end,
        })

        lspconfig.vtsls.setup({})
        lspconfig.emmet_ls.setup({
            filetypes = {
                "astro",
                "css",
                "eruby",
                "html",
                "javascript",
                "javascriptreact",
                "less",
                "sass",
                "scss",
                "svelte",
                "pug",
                "typescriptreact",
                "vue",
            },
            capabilities = capabilities,
            on_attach = on_attach,
        })
        lspconfig.tailwindcss.setup({})

        -- python LSPs

        lspconfig.pyright.setup({})
        -- https://github.com/astral-sh/ruff
        lspconfig.ruff.setup({
            capabilities = capabilities,
            autostart = os.getenv("DISABLE_RUFF") ~= "1",
            on_attach = function(client, bufnr)
                client.server_capabilities.hoverProvider = false
                on_attach(client, bufnr)
            end,
            settings = {
                prioritizeFileConfiguration = true,
                fixAll = true,
                organizeImports = true,
            },
        })

        local cmp = require("cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            sources = cmp.config.sources({
                { name = "path" },
                { name = "nvim_lsp" },
                { name = "luasnip", keyword_length = 2 },
                { name = "buffer",  keyword_length = 3 },
            }),
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-k>"] = cmp.mapping.confirm({ select = true }),
                ["<C-space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            }),
        })
    end,
}
