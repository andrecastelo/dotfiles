require("andrecastelo.remap")
require("andrecastelo.set")

vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])
