# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration written in Lua, using lazy.nvim as the plugin manager. The configuration is VSCode-aware and conditionally loads plugins/settings based on whether running in VSCode or native Neovim.

## Development Commands

### Testing startup time
```bash
./startup-time.sh
```
Measures Neovim startup performance and displays the last 5 lines of the startup log.

### LSP and tooling
- LSP servers are managed through Mason (`lua/plugins/lsp.lua`)
- Formatting uses Conform.nvim with format-on-save enabled (500ms timeout)
- The configuration uses the new `vim.lsp.config` API (migrating from lspconfig)

## Architecture

### Entry point
- `init.lua`: Bootstraps lazy.nvim, sets leader key to space, loads plugins and config

### Configuration structure
```
lua/
├── config/
│   ├── init.lua         # Loads remap and set modules
│   ├── remap.lua        # All keymaps using which-key
│   └── set.lua          # Vim options (numbers, tabs, undo, fold, etc.)
├── plugins/
│   ├── init.lua         # Core plugins (mini.pairs, mini.surround, tokyonight, etc.)
│   ├── lsp.lua          # LSP configuration with lsp-zero v4
│   ├── conform.lua      # Formatting configuration
│   ├── telescope.lua    # Fuzzy finder with custom keymaps
│   ├── harpoon.lua      # Quick file navigation
│   ├── treesitter.lua   # Syntax highlighting
│   └── [other plugins]  # Individual plugin configurations
└── andrecastelo/
    ├── harpoon.lua      # Custom Harpoon + Telescope integration
    └── utils.lua        # Utility functions (e.g., format with range support)
```

### VSCode integration
Most plugins check `not vim.g.vscode` and are disabled in VSCode. Core keybindings (J/K for moving lines, search centering, etc.) work in both environments.

### Plugin loading pattern
- Each plugin file in `lua/plugins/` returns a lazy.nvim spec table
- Plugins are lazy-loaded using events (`VimEnter`, `BufWritePost`, etc.) or on command
- All plugins define `enabled = not vim.g.vscode` except for core functionality

## LSP Configuration

### Installed servers (via Mason)
- **Lua**: lua_ls (with Neovim-specific settings)
- **JavaScript/TypeScript**: vtsls, eslint (with auto-fix on save)
- **Frontend**: html, emmet_ls, tailwindcss
- **Python**: pyright, ruff (can be disabled via `DISABLE_RUFF=1`)
- **Go**: gopls
- **Markdown**: marksman

### LSP keybindings (defined in `on_attach`)
- `gd`: Go to definition
- `<leader>vws`: Workspace symbol search
- `<leader>vd`: Open diagnostic float
- `[d` / `]d`: Next/previous diagnostic
- `<leader>vca`: Code actions
- `<leader>vrr`: Find references
- `<leader>vrn`: Rename symbol
- `gl`: Open diagnostic float

### Formatting
Conform.nvim handles formatting with these formatters by filetype:
- JS/TS/React/Svelte/CSS/HTML/JSON/YAML/Markdown: prettier
- Lua: stylua
- Python: ruff_organize_imports + ruff_format
- Go: goimports + gofmt

Format on save is enabled with 500ms timeout. Manual format: `<leader>f` or `:Format`

## Key Navigation Patterns

### Tmux integration
- Uses christoomey/vim-tmux-navigator
- `<C-h/j/k/l>` navigate between Vim and tmux panes

### Harpoon workflow
- `<leader>a`: Mark file
- `<C-e>`: Toggle Harpoon menu
- `<leader>1-4`: Jump to marked files 1-4
- `<C-b>` / `<C-n>`: Jump to first/second marked file
- `<leader>.` / `<leader>,`: Next/previous marked file
- **Custom integration**: `<C-s>` in Telescope marks multiple files to Harpoon

### Telescope
- `<leader><space>`: Find all files (respects .gitignore, excludes node_modules/venv)
- `<C-p>` / `<M-p>`: Git files
- `<leader>/`: Live grep (also works in visual mode to grep selection)
- `<leader>]/`: Grep string with input prompt
- `<leader>b`: Buffer search (sorted by MRU)
- `<leader>m`: Marks
- Vertical layout (95% width/height) with preview at top

## Custom Commands and Functions

### Visual selection wrapping
`:Cn` - Wraps visual selection in `{cn(...)}` (i18n helper pattern)

### Format command
`:Format` - Formats buffer or range using Conform

### Custom keybinds
- `J` in normal: Join lines without moving cursor
- `J`/`K` in visual: Move selected lines up/down
- `<leader>s`: Search and replace word under cursor
- `<leader>y` / `<leader>Y`: Yank to system clipboard
- `<leader>d`: Delete without copying
- `p` in visual: Paste without overwriting register
- `<` / `>` in visual: Continuous indenting (stays in visual mode)

## Important Implementation Details

### Diagnostics
- Virtual text is disabled
- Diagnostics use floating windows with rounded borders
- Signs: ✘ (error), ▲ (warn), ⚑ (hint), "" (info)

### Folding
- Uses Treesitter for fold expressions
- Fold column enabled
- Method: `expr`, Expression: `nvim_treesitter#foldexpr()`

### Editor settings
- Relative line numbers
- 4-space indentation (tabs expanded to spaces)
- Persistent undo (stored in `~/.vim/undodir`)
- No swap files or backups
- Scroll offset: 100 (centers cursor)
- Color column at 100 characters
- Block cursor (`guicursor = ""`)

### Telescope custom behavior
- Excludes: `*.js.map`, `.yarn`, `yarn.lock`
- `<C-h>` / `<C-l>`: Cycle search history
- `<leader>x` in buffers: Delete buffer

## Adding new LSP servers

1. Add to `ensure_installed` in `lua/plugins/lsp.lua`
2. Configure via lspconfig: `lspconfig.[server].setup({})`
3. For special handling, define custom `on_attach` like eslint's auto-fix
4. For formatting, add to `formatters_by_ft` in `lua/plugins/conform.lua`

## Adding new plugins

Create a new file in `lua/plugins/[plugin-name].lua` that returns a lazy.nvim spec:
```lua
return {
    "author/plugin-name",
    enabled = not vim.g.vscode,  -- Most plugins should have this
    config = function()
        -- Plugin configuration
    end,
}
```

For keybindings, use which-key via `require("which-key").add({...})` in the config function.
