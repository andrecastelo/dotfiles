require("config.remap")
require("config.set")

vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
	pattern = "*",
	command = "normal zR",
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = "",
	command = "FormatWrite",
})
