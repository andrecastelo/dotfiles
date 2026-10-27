if not vim.g.vscode then
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2

    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true

    vim.keymap.set({ "n", "x" }, "j", function()
        return vim.v.count == 0 and "gj" or "j"
    end, { buffer = true, expr = true })

    vim.keymap.set({ "n", "x" }, "k", function()
        return vim.v.count == 0 and "gk" or "k"
    end, { buffer = true, expr = true })
end
