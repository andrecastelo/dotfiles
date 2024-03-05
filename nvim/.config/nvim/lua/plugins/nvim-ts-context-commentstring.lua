return {
    'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
        require('nvim-ts-context-commentstring').setup({
            enable_autocmd = false,
        })
    end
}
