# Neovim configuration based on NvChad

This repository contains my personal setup for Neovim built on top of [NvChad](https://github.com/NvChad/NvChad). All NvChad modules are loaded as a plugin through [lazy.nvim](https://github.com/folke/lazy.nvim) and extended with additional plugins and options.

<img width="2048" alt="nvim" src="https://github.com/user-attachments/assets/cf54a56d-b4c6-4215-a1c0-e6cc8d2826fa" />

## Pre-requisites

- **Neovim** 0.11 or higher (0.12+ for `tree-sitter-manager`)
- **Nerd Font** set as your terminal font (e.g. `JetBrainsMono Nerd Font`).
  Avoid variants ending with *Mono* to prevent small icons.
- **Ripgrep** for Telescope search *(optional)*
- **GCC** (on Windows use `mingw` and add it to your `PATH`)
- **make** (on Windows install `GnuWin32` and add it to your `PATH`)
- **Node.js** for the JavaScript/TypeScript LSP and the JS/TS debugger *(optional)*
- **Go** for `gopls` and building the `cursortab` server *(optional)*
- **tree-sitter** CLI for `tree-sitter-manager` *(optional)*
- **ssh**, **rsync**, **python3** for `remote-ssh` *(optional)*
- Language toolchains (Go, PHP, Python, …) only for the languages you use.
  LSP servers, formatters and linters themselves are installed automatically by Mason.
- Delete any previous Neovim configuration folders before installing.

## Installation

1. Remove or move your current `~/.config/nvim` directory.
2. Clone this repository into `~/.config/nvim`:
   ```bash
   git clone https://github.com/wh1teend/nvim ~/.config/nvim
   ```
3. Start Neovim. On the first launch `lazy.nvim` will install all plugins and
   `mason-tool-installer` will pull the LSP servers, formatters and linters
   declared in `lua/language.lua`.

## Update

To synchronize plugins run:

```vim
:Lazy sync
```

## Key Features

- Light and dark `ayu` themes with quick switching.
- Preconfigured LSP for HTML, CSS, JSON, Python, TypeScript/JavaScript, Vue, Prisma, PHP and Go.
- A single language registry (`lua/language.lua`) drives LSP, Treesitter, formatters,
  linters and automatic Mason installs.
- Automatic formatting (`conform.nvim`) and linting (`nvim-lint`) on save.
- AI completion via Codeium, Copilot and Cursor-style tab predictions, plus AI
  diagnostic explanations with `wtf.nvim`.
- File manager `nvim-tree`, fuzzy search with `telescope`/`fzf-lua`, undo-tree viewer (`atone`).
- Debugging via `nvim-dap` with the `dap-ui` interface (JS/TS through `vscode-js-debug`,
  Python via `debugpy`).
- Dependency version hints for Rust (`crates`) and npm (`package-info`), `.env`
  management (`ecolog`) and remote editing over SSH (`remote-ssh`).
- Quality-of-life: autopairs, smart backspace, cursor-word highlight, block-context
  virtual text and floating terminals.

## Structure

```
init.lua              -- entry point: bootstraps lazy.nvim and loads modules
lua/
├── chadrc.lua        -- NvChad UI/theme overrides
├── language.lua      -- single registry: LSP, Treesitter, formatters, linters, Mason
├── utils.lua         -- small helper functions
├── core/             -- editor settings: options, autocmds, commands, mappings
├── features/         -- custom commands (autosave, show OS)
├── configs/          -- per-plugin settings (one file per plugin)
└── plugins/          -- lazy.nvim plugin specs (one file per plugin)
```

## Plugin List

The plugins below are grouped by their main purpose to make it easier to see what each one adds to the configuration.

### Libraries & dependencies
- [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim) – common Lua functions
- [MunifTanjim/nui.nvim](https://github.com/MunifTanjim/nui.nvim) – UI components
- [nvim-neotest/nvim-nio](https://github.com/nvim-neotest/nvim-nio) – async IO helpers
- [nvzone/volt](https://github.com/nvzone/volt) – UI framework
- [folke/snacks.nvim](https://github.com/folke/snacks.nvim) – quality-of-life library
- [rcarriga/nvim-notify](https://github.com/rcarriga/nvim-notify) – notification UI

### Interface & appearance
- [mawkler/modicator.nvim](https://github.com/mawkler/modicator.nvim) – line-number color by mode
- [cpea2506/relative-toggle.nvim](https://github.com/cpea2506/relative-toggle.nvim) – smart relative line numbers
- [mawkler/hml.nvim](https://github.com/mawkler/hml.nvim) – H/M/L line markers
- [hiphish/rainbow-delimiters.nvim](https://github.com/hiphish/rainbow-delimiters.nvim) – rainbow brackets
- [m-demare/hlargs.nvim](https://github.com/m-demare/hlargs.nvim) – highlight function arguments
- [sontungexpt/stcursorword](https://github.com/sontungexpt/stcursorword) – highlight the word under the cursor
- [andersevenrud/nvim_context_vt](https://github.com/andersevenrud/nvim_context_vt) – block context as virtual text
- [Fildo7525/pretty_hover](https://github.com/Fildo7525/pretty_hover) – nicer LSP hover
- [hedyhli/outline.nvim](https://github.com/hedyhli/outline.nvim) – symbol outline
- [j-hui/fidget.nvim](https://github.com/j-hui/fidget.nvim) – LSP progress UI
- [nvzone/showkeys](https://github.com/nvzone/showkeys) – display key presses
- [matbme/JABS.nvim](https://github.com/matbme/JABS.nvim) – floating buffer switcher

### Navigation & search
- [nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) – file explorer
- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) – powerful search
- [ibhagwan/fzf-lua](https://github.com/ibhagwan/fzf-lua) – fzf-based finder
- [folke/flash.nvim](https://github.com/folke/flash.nvim) – quick jump navigation
- [LintaoAmons/cd-project.nvim](https://github.com/LintaoAmons/cd-project.nvim) – switch between projects
- [XXiaoA/atone.nvim](https://github.com/XXiaoA/atone.nvim) – undo-tree viewer with diff previews

### Editing
- [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs) – auto-insert matching pairs
- [windwp/nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) – auto close/rename HTML & JSX tags
- [qwavies/smart-backspace.nvim](https://github.com/qwavies/smart-backspace.nvim) – context-aware backspace
- [sontungexpt/bim.nvim](https://github.com/sontungexpt/bim.nvim) – instant insert-mode mappings without the `timeoutlen` wait
- [necrom4/convy.nvim](https://github.com/necrom4/convy.nvim) – convert between encodings, units and colors

### LSP, completion & AI
- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) – configure built-in LSP
- [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) – completion engine
- [Exafunction/windsurf.nvim](https://github.com/Exafunction/windsurf.nvim) – Codeium completion source
- [zbirenbaum/copilot.lua](https://github.com/zbirenbaum/copilot.lua) – GitHub Copilot
- [zbirenbaum/copilot-cmp](https://github.com/zbirenbaum/copilot-cmp) – Copilot as a `nvim-cmp` source
- [cursortab/cursortab.nvim](https://github.com/cursortab/cursortab.nvim) – Cursor-style tab/edit predictions
- [SergioRibera/cmp-dotenv](https://github.com/SergioRibera/cmp-dotenv) – `.env` completion source
- [sontungexpt/better-diagnostic-virtual-text](https://github.com/sontungexpt/better-diagnostic-virtual-text) – inline diagnostics
- [piersolenski/wtf.nvim](https://github.com/piersolenski/wtf.nvim) – explain diagnostics with AI
- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) – Treesitter highlighting

### Formatting & tooling
- [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim) – formatter runner
- [mfussenegger/nvim-lint](https://github.com/mfussenegger/nvim-lint) – linter runner
- [mason-org/mason.nvim](https://github.com/mason-org/mason.nvim) – LSP/DAP/linter/formatter package manager
- [WhoIsSethDaniel/mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) – auto-install tools from the language registry
- [romus204/tree-sitter-manager.nvim](https://github.com/romus204/tree-sitter-manager.nvim) – Tree-sitter parser manager

### Language support
- [pmizio/typescript-tools.nvim](https://github.com/pmizio/typescript-tools.nvim) – TypeScript tooling
- [dmmulroy/ts-error-translator.nvim](https://github.com/dmmulroy/ts-error-translator.nvim) – clearer TypeScript errors
- [yelog/i18n.nvim](https://github.com/yelog/i18n.nvim) – i18n translation hints
- [Kenzo-Wada/boundary.nvim](https://github.com/Kenzo-Wada/boundary.nvim) – mark React client-component usages
- [linux-cultist/venv-selector.nvim](https://github.com/linux-cultist/venv-selector.nvim) – Python virtualenv selector
- [Saecki/crates.nvim](https://github.com/Saecki/crates.nvim) – Rust crate versions in `Cargo.toml`
- [vuki656/package-info.nvim](https://github.com/vuki656/package-info.nvim) – npm package versions in `package.json`

### Debugging
- [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap) – debug adapter protocol client
- [rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) – UI for nvim-dap
- [mfussenegger/nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python) – Python debugging

### Tools & utilities
- [folke/trouble.nvim](https://github.com/folke/trouble.nvim) – diagnostics list
- [nvzone/floaterm](https://github.com/nvzone/floaterm) – floating terminal
- [ingur/floatty.nvim](https://github.com/ingur/floatty.nvim) – floating terminal manager
- [ph1losof/ecolog.nvim](https://github.com/ph1losof/ecolog.nvim) – environment variable manager
- [inhesrom/remote-ssh.nvim](https://github.com/inhesrom/remote-ssh.nvim) – edit remote files over SSH with LSP *(with [telescope-remote-buffer](https://github.com/inhesrom/telescope-remote-buffer))*
- [wakatime/vim-wakatime](https://github.com/wakatime/vim-wakatime) – coding stats

## Credits

Configuration built on [NvChad](https://nvchad.com) by [Siduck](https://github.com/siduck) and the NvChad team.
