local utils = require("config.utils")
local excluded_paths = {
    "lib/python%d.%d+/site-packages/",
}

return {
    "nvimtools/none-ls.nvim",
    config = function()
        -- https://github.com/nvimtools/none-ls.nvim
        local diagnostics_format = "[#{c}] #{m} (#{s})"
        local null_ls = require("null-ls")
        local nhelpers = require("null-ls.helpers")
        local formatting = null_ls.builtins.formatting
        local diagnostics = null_ls.builtins.diagnostics
        local code_actions = null_ls.builtins.code_actions

        null_ls.setup({
            -- python
            diagnostics.flake8.with({
                diagnostics_format = diagnostics_format,
                prefer_local = ".venv/bin",
                cwd = nhelpers.cache.by_bufnr(function(params)
                    return require("null-ls.utils").root_pattern(
                        ".flake8",
                        "pyproject.toml",
                        "setup.py",
                        "setup.cfg",
                        "requirements.txt",
                        "Pipfile",
                        "pyrightconfig.json"
                    )(params.bufname)
                end),
                runtime_condition = nhelpers.cache.by_bufnr(function()
                    local bufname = vim.api.nvim_buf_get_name(0)
                    for _, path in pairs(excluded_paths) do
                        if bufname:match(path) ~= nil then
                            return false
                        end
                    end

                    local pyproject = utils.find_file("pyproject.toml")
                    if pyproject then
                        local file = assert(io.open(pyproject, "r"))
                        local content = file:read("*all")
                        if string.find(content, "tool.ruff") then
                            return false
                        end
                    end
                    return true
                end),
            }),
            formatting.isort.with({
                prefer_local = ".venv/bin",
                cwd = nhelpers.cache.by_bufnr(function(params)
                    return require("null-ls.utils").root_pattern(
                        ".isort.cfg",
                        "pyproject.toml",
                        "setup.py",
                        "setup.cfg",
                        "requirements.txt",
                        "Pipfile",
                        "pyrightconfig.json"
                    )(params.bufname)
                end),
                extra_args = { "--profile", "black" },
                runtime_condition = nhelpers.cache.by_bufnr(function()
                    local bufname = vim.api.nvim_buf_get_name(0)
                    for _, path in pairs(excluded_paths) do
                        if bufname:match(path) ~= nil then
                            return false
                        end
                    end

                    local pyproject = utils.find_file("pyproject.toml")
                    if pyproject then
                        local file = assert(io.open(pyproject, "r"))
                        local content = file:read("*all")
                        if string.find(content, "tool.ruff.isort") then
                            return false
                        end
                    end
                    return true
                end),
            }),
            formatting.black.with({
                prefer_local = ".venv/bin",
                cwd = nhelpers.cache.by_bufnr(function(params)
                    return require("null-ls.utils").root_pattern(
                        "pyproject.toml",
                        "setup.py",
                        "setup.cfg",
                        "requirements.txt",
                        "Pipfile",
                        "pyrightconfig.json"
                    )(params.bufname)
                end),
                extra_args = { "--fast" },
                runtime_condition = nhelpers.cache.by_bufnr(function()
                    local bufname = vim.api.nvim_buf_get_name(0)
                    for _, path in pairs(excluded_paths) do
                        if bufname:match(path) ~= nil then
                            return false
                        end
                    end

                    local pyproject = utils.find_file("pyproject.toml")
                    if pyproject then
                        local file = assert(io.open(pyproject, "r"))
                        local content = file:read("*all")
                        if string.find(content, "tool.ruff.format") then
                            return false
                        end
                    end
                    return true
                end),
            }),
            diagnostics.ruff.with({
                diagnostics_format = diagnostics_format,
                prefer_local = ".venv/bin",
                cwd = nhelpers.cache.by_bufnr(function(params)
                    return require("null-ls.utils").root_pattern(
                        "pyproject.toml",
                        "setup.py",
                        "setup.cfg",
                        "requirements.txt",
                        "Pipfile",
                        "pyrightconfig.json"
                    )(params.bufname)
                end),
                runtime_condition = nhelpers.cache.by_bufnr(function()
                    local bufname = vim.api.nvim_buf_get_name(0)
                    for _, path in pairs(excluded_paths) do
                        if bufname:match(path) ~= nil then
                            return false
                        end
                    end

                    local pyproject = utils.find_file("pyproject.toml")
                    if pyproject then
                        local file = assert(io.open(pyproject, "r"))
                        local content = file:read("*all")
                        if string.find(content, "tool.ruff") then
                            return true
                        end
                    end
                    return false
                end),
            }),
            formatting.ruff.with({
                prefer_local = ".venv/bin",
                cwd = nhelpers.cache.by_bufnr(function(params)
                    return require("null-ls.utils").root_pattern(
                        "pyproject.toml",
                        "setup.py",
                        "setup.cfg",
                        "requirements.txt",
                        "Pipfile",
                        "pyrightconfig.json"
                    )(params.bufname)
                end),
                runtime_condition = nhelpers.cache.by_bufnr(function()
                    local pyproject = utils.find_file("pyproject.toml")
                    if pyproject then
                        local file = assert(io.open(pyproject, "r"))
                        local content = file:read("*all")
                        if string.find(content, "tool.ruff") then
                            return true
                        end
                    end
                    return false
                end),
                extra_args = { "--unfixable", "T20,ERA001,F841" },
            }),
            formatting.ruff_format.with({
                prefer_local = ".venv/bin",
                cwd = nhelpers.cache.by_bufnr(function(params)
                    return require("null-ls.utils").root_pattern(
                        "pyproject.toml",
                        "setup.py",
                        "setup.cfg",
                        "requirements.txt",
                        "Pipfile",
                        "pyrightconfig.json"
                    )(params.bufname)
                end),
                runtime_condition = nhelpers.cache.by_bufnr(function()
                    local pyproject = utils.find_file("pyproject.toml")
                    if pyproject then
                        local file = assert(io.open(pyproject, "r"))
                        local content = file:read("*all")
                        if string.find(content, "tool.ruff.format") then
                            return true
                        end
                    end
                    return false
                end),
            }),

            -- javascript/typescript
            formatting.prettier.with({
                prefer_local = "node_modules/.bin",
            }),
            diagnostics.eslint,
            code_actions.eslint,

            -- golang
            formatting.gofmt,

            -- just file
            formatting.just,

            -- sh/bash
            code_actions.shellcheck,
            diagnostics.shellcheck.with({
                diagnostics_format = diagnostics_format,
            }),
            formatting.shfmt.with({
                extra_args = function(params)
                    return { "-i", tostring(vim.opt_local.shiftwidth:get()) }
                end,
            }),

            -- lua
            formatting.stylua.with({
                condition = function(utils)
                    return utils.root_has_file({ "stylua.toml", ".stylua.toml" })
                end,
            }),

            -- refactoring
            code_actions.refactoring,

            -- json
            formatting.fixjson,

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
                        YAMLFIX_LINE_LENGTH = tostring(vim.opt_local.textwidth:get() + 1),
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

            -- toml
            formatting.taplo,
        })
    end,
}