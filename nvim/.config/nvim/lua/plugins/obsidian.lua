return {
  "epwalsh/obsidian.nvim",
  enabled = not vim.g.vscode,
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "/Users/andrecastelo/Projects/personal/notes",
      },
    },
    daily_notes = {
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = nil
    },
    completion = {
      -- Set to false to disable completion.
      nvim_cmp = true,
      -- Trigger completion at 2 chars.
      min_chars = 2,
    },
    new_notes_location = "0-inbox",
    disable_frontmatter = true,
    ui = {
      enable = false,
    }
  }


}
