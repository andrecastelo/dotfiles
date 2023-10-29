require("config.remap")
require("config.set")

vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])
