return {
	"L3MON4D3/LuaSnip",
	dependencies = { "rafamadriz/friendly-snippets" },

	config = function()
		require("luasnip.loaders.from_vscode").lazy_load()

		local ls = require("luasnip")
		local wk = require("which-key")
		wk.add({
			{
				"<C-l>",
				function()
					ls.jump(1)
				end,
				mode = { "i", "s" },
			},
			{
				"<C-h>",
				function()
					ls.jump(-1)
				end,
				mode = { "i", "s" },
			},
		})
	end,
}
