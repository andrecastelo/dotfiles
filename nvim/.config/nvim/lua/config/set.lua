if not vim.g.vscode then
    vim.opt.nu = true
    vim.opt.relativenumber = true

    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.expandtab = true

    vim.opt.eol = true

    vim.opt.smartindent = true

    vim.opt.wrap = false

    vim.opt.swapfile = false
    vim.opt.backup = false
    vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
    vim.opt.undofile = true

    vim.opt.hlsearch = false
    vim.opt.incsearch = true

    vim.opt.termguicolors = true

    vim.opt.splitright = true

    -- disable netrw at the very start of your init.lua
    -- vim.g.loaded_netrw = 1
    -- vim.g.loaded_netrwPlugin = 1

    vim.opt.scrolloff = 100
    vim.opt.signcolumn = "yes"
    vim.opt.isfname:append("@-@")

    vim.opt.updatetime = 50

    vim.opt.colorcolumn = "100"

    vim.wo.foldcolumn = "1"
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

    vim.opt.guicursor = ""
end
