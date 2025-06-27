# Neovim Configuration based on NvChad

This repository contains my personal setup for Neovim built on top of [NvChad](https://github.com/NvChad/NvChad). All NvChad modules are loaded as a plugin through [lazy.nvim](https://github.com/folke/lazy.nvim) and extended with additional plugins and options.

<img width="2048" alt="nvim" src="https://github.com/user-attachments/assets/cf54a56d-b4c6-4215-a1c0-e6cc8d2826fa" />

## Pre-requisites

- **Neovim** 0.11 or higher
- **Nerd Font** set as your terminal font (e.g. `JetBrainsMono Nerd Font`).
  Avoid variants ending with *Mono* to prevent small icons.
- **Ripgrep** for Telescope search *(optional)*
- **GCC** (on Windows use `mingw` and add it to your `PATH`)
- **make** (on Windows install `GnuWin32` and add it to your `PATH`)
- Delete any previous Neovim configuration folders before installing.

## Installation

1. Remove or move your current `~/.config/nvim` directory.
2. Clone this repository into `~/.config/nvim`:
   ```bash
   git clone https://github.com/<your_account>/nvim ~/.config/nvim
   ```
3. Start Neovim. On the first launch `lazy.nvim` will automatically install all required plugins.

## Update

To synchronize plugins run:

```vim
:Lazy sync
```

## Key Features

- Light and dark `ayu` themes with quick switching.
- Preconfigured LSP for HTML, CSS, Python, TypeScript, PHP and more.
- Automatic formatting and linting on save.
- AI helpers (Codeium, Copilot) through `nvim-cmp`.
- File manager `nvim-tree`, fuzzy searching with `telescope` and TODO highlight.
- Debugging via `nvim-dap` with `dap-ui` interface.
- Extra tools: `floaterm` terminal, `undotree` history, `wakatime` tracking and others.

## Plugin List

The plugins below are grouped by their main purpose to make it easier to see what each one adds to the configuration.

### Core libraries
- [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim) – common Lua functions
- [MunifTanjim/nui.nvim](https://github.com/MunifTanjim/nui.nvim) – UI components
- [nvim-neotest/nvim-nio](https://github.com/nvim-neotest/nvim-nio) – async helpers
- [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) – file icons

### Interface & theming
- [yetone/avante.nvim](https://github.com/yetone/avante.nvim) – colorscheme
- [mawkler/modicator.nvim](https://github.com/mawkler/modicator.nvim) – mode indicator
- [stevearc/dressing.nvim](https://github.com/stevearc/dressing.nvim) – improved input UI
- [max397574/better-escape.nvim](https://github.com/max397574/better-escape.nvim) – fast escape
- [karb94/neoscroll.nvim](https://github.com/karb94/neoscroll.nvim) – smooth scrolling
- [sitiom/nvim-numbertoggle](https://github.com/sitiom/nvim-numbertoggle) – smart line numbers
- [briangwaltney/paren-hint.nvim](https://github.com/briangwaltney/paren-hint.nvim) – highlight parentheses
- [hiphish/rainbow-delimiters.nvim](https://github.com/hiphish/rainbow-delimiters.nvim) – rainbow brackets
- [Fildo7525/pretty_hover](https://github.com/Fildo7525/pretty_hover) – nicer LSP hover
- [hedyhli/outline.nvim](https://github.com/hedyhli/outline.nvim) – symbol outline
- [m-demare/hlargs.nvim](https://github.com/m-demare/hlargs.nvim) – highlight arguments
- [MeanderingProgrammer/render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) – render Markdown
- [HakonHarnes/img-clip.nvim](https://github.com/HakonHarnes/img-clip.nvim) – paste images
- [nvzone/volt](https://github.com/nvzone/volt) – floaterm theme helper
- [ravitemer/mcphub.nvim](https://github.com/ravitemer/mcphub.nvim) – Avante integrations

### File browsing & search
- [nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) – file explorer
- [ibhagwan/fzf-lua](https://github.com/ibhagwan/fzf-lua) – fuzzy finder
- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) – powerful search
- [echasnovski/mini.pick](https://github.com/echasnovski/mini.pick) – lightweight picker
- [nvzone/showkeys](https://github.com/nvzone/showkeys) – show key presses
- [nvzone/floaterm](https://github.com/nvzone/floaterm) – floating terminal
- [mbbill/undotree](https://github.com/mbbill/undotree) – undo history browser

### LSP & completion
- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) – configure built-in LSP
- [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) – completion engine
- [Exafunction/windsurf.nvim](https://github.com/Exafunction/windsurf.nvim) – Codeium source
- [zbirenbaum/copilot.lua](https://github.com/zbirenbaum/copilot.lua) – GitHub Copilot
- [windwp/nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) – auto close tags
- [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim) – formatter
- [mfussenegger/nvim-lint](https://github.com/mfussenegger/nvim-lint) – linting
- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) – Treesitter highlighting

### Debugging
- [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap) – debug adapter
- [mxsdev/nvim-dap-vscode-js](https://github.com/mxsdev/nvim-dap-vscode-js) – JS debugger
- [rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) – UI for nvim-dap

### Utilities
- [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim) – highlight TODOs
- [folke/trouble.nvim](https://github.com/folke/trouble.nvim) – diagnostics list
- [wakatime/vim-wakatime](https://github.com/wakatime/vim-wakatime) – coding stats


## Credits

Configuration built on [NvChad](https://nvchad.com) by [Siduck](https://github.com/siduck) and the NvChad team.
