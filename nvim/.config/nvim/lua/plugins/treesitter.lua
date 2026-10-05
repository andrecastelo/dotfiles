return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    enabled = not vim.g.vscode,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup()
        require("nvim-treesitter").install({
            "vimdoc", "javascript", "typescript", "python", "c",
            "lua", "vim", "query", "go", "markdown", "markdown_inline",
            -- vue SFCs inject html/css/js into the parent parser, so the
            -- injected languages have to be installed alongside it.
            "vue", "html", "css",
            "gitcommit", "git_rebase", "diff",
        })
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(ev)
                local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
                if not lang then
                    return
                end
                -- Starting treesitter clears 'syntax', so bail out unless a
                -- highlights query exists -- otherwise the buffer ends up with
                -- neither treesitter nor legacy syntax highlighting.
                if not vim.treesitter.query.get(lang, "highlights") then
                    return
                end
                local ok, err = pcall(vim.treesitter.start, ev.buf)
                if not ok then
                    vim.notify(("treesitter %s: %s"):format(lang, err), vim.log.levels.WARN)
                end
            end,
        })
    end,
}
