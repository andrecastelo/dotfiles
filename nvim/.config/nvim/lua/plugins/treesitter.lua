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
        })
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(ev)
                pcall(vim.treesitter.start, ev.buf)
            end,
        })
    end,
}
