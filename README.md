# Neovim configuration based on NvChad

This repository contains my personal setup for Neovim built on top of [NvChad](https://github.com/NvChad/NvChad). All NvChad modules are loaded as a plugin through [lazy.nvim](https://github.com/folke/lazy.nvim) and extended with additional plugins and options.

<img width="2048" alt="nvim" src="https://github.com/user-attachments/assets/cf54a56d-b4c6-4215-a1c0-e6cc8d2826fa" />

## Pre-requisites

- **Neovim** 0.12 or higher (required by `tree-sitter-manager`)
- **Nerd Font** set as your terminal font (e.g. `JetBrainsMono Nerd Font`).
  Avoid variants ending with *Mono* to prevent small icons.
- **Ripgrep** for Telescope search *(optional)*
- **GCC** (on Windows use `mingw` and add it to your `PATH`)
- **make** (on Windows install `GnuWin32` and add it to your `PATH`)
- **Node.js** for JS/TS/Vue language servers, web tooling and JS/PHP debug adapters.
- **Python 3**, **Go** and **PHP** for their respective tooling and debug sessions.
- **Lua/LuaJIT** and **LuaRocks** for Mason's luacheck installation (Lua tooling).
- **fd** for `:VenvSelect` virtualenv discovery.
- **Chrome/Chromium** for browser debug launches; the application dev server must be running.
- **Xdebug 3** enabled in PHP for PHP debugging; Mason installs the adapter, not the PHP extension.
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
   `mason-tool-installer` will pull the LSP servers, formatters, linters and debug
   adapters declared in `lua/language.lua`.

Codeium/Windsurf is the only AI completion provider and integrates with `nvim-cmp`.
On first use, authenticate with `:Codeium Auth`.

## Update

To synchronize plugins run:

```vim
:Lazy sync
```

## Key Features

- Light and dark `ayu` themes with quick switching.
- Preconfigured LSP for Lua, Vimscript, HTML, CSS, JSON/JSONC, Python, TypeScript/JavaScript, Vue, Prisma, PHP and Go.
- Automatic formatting (`conform.nvim`) and linting (`nvim-lint`) on save.
- A single language registry (`lua/language.lua`) drives LSP, Treesitter, formatters,
  linters, DAP, language tools and automatic Mason installs.
- AI completion via Codeium/Windsurf through `nvim-cmp`.
- File manager `nvim-tree`, fuzzy search with `telescope`/`fzf-lua`, TODO highlighting
  and undo-tree viewer (`atone`).
- Debugging via `nvim-dap` and `dap-ui`: Node/browser JavaScript and TypeScript, Python, Go, PHP and Neovim Lua.
- `.env` management (`ecolog`) and remote editing over SSH (`remote-ssh`).
- Quality-of-life: autopairs, smart backspace, cursor-word highlight, block-context
  virtual text, floating terminals and `wakatime` tracking.

## Structure

```
init.lua              -- bootstraps lazy.nvim and initializes core/features
lua/
├── chadrc.lua        -- NvChad UI/theme overrides
├── language.lua      -- language profiles: LSP, syntax, format, lint, DAP, tools
├── project_root.lua  -- shared canonical root resolver for DAP and linters
├── utils.lua         -- small editor helper functions
├── core/             -- options, autocmds, commands, mappings
├── features/         -- autosave and show_os commands/behavior
├── configs/
│   ├── lazy.lua      -- bootstrap options, independent of plugin categories
│   ├── editing/      -- completion, Codeium, insert behavior, undo
│   ├── development/ -- LSP, format, lint, DAP, Mason and language tools
│   │   ├── lsp/     -- PHP/Vue server settings
│   │   ├── dap/     -- language adapters/configurations and UI setup
│   │   └── linters/ -- tool-specific overrides and project cwd adaptation
│   ├── syntax/      -- Treesitter and structural highlighting
│   ├── navigation/  -- file explorer, symbol outline, relative numbers
│   ├── ui/          -- diagnostics, hover, progress and visual settings
│   └── workflow/    -- terminal, environment, remote editing, TODOs
└── plugins/
    ├── init.lua      -- explicit imports of the six spec categories
    ├── editing/      -- completion, insert behavior, undo
    ├── development/  -- LSP, formatting, lint, DAP, language tools
    ├── syntax/       -- Treesitter and structural highlighting
    ├── navigation/   -- files, symbols, jumps, projects
    ├── ui/           -- diagnostic/hover UI and visual enhancements
    └── workflow/     -- terminal, environment, remote editing, tracking
```

`plugins/init.lua` is the only user-spec import in the bootstrap. It explicitly
imports each category: lazy.nvim does not recursively discover arbitrary nested
directories. Category folders contain specs directly, without additional index
modules. Grouping reflects a plugin's main purpose, not its dependencies.

Specs and their configs use readable `snake_case` module names and matching
categories, such as `plugins.navigation.nvim_tree` and
`configs.navigation.nvim_tree`. No empty config files are created for plugins
that need no custom settings. LSP/DAP variants and linter helpers live under
`configs/development/`; Codeium belongs with completion in `configs/editing/`.
The TypeScript error translator and i18n have separate development specs. Coupled
integrations stay together: cmp with Codeium/cmp-dotenv, and DAP with its UI.


### Language settings

Edit `lua/language.lua` to configure language support. Settings are grouped under
`languages.<profile>`, so a language's servers, syntax, formatters, linters,
debuggers and tools live together. Profiles can cover multiple filetypes, such
as CSS/SCSS/LESS, JSON/JSONC, JavaScript/TypeScript and JSX/TSX.

| Profile field | Purpose |
| --- | --- |
| `filetypes` | Filetypes sharing the profile's formatting, linting and default DAP configurations |
| `highlighting` | Treesitter parsers; shared parsers are deduplicated |
| `lsp` | Server tuples: `{ server_name }` or `{ server_name, options }` |
| `formatters`, `linters` | Ordered formatter chain and enabled linters |
| `format_on_save` | Optional override merged with the global save-time policy |
| `linter_options` | Optional tool-specific linter overrides |
| `dap` | List of records: optional Mason package as the first item, adapter pair, configurations and optional filetype override |
| `venv` | Python project-environment directory names |
| `tools` | Actual plugin settings, such as React boundary and JavaScript i18n options |

Global `format_on_save` defines the default formatting policy. Global `mason`
contains installer options, and `packages` maps tool/server names to Mason
package names. There are no separate top-level LSP, syntax, quality, DAP or tool
registries: plugin configs derive their settings directly from the profiles.

For example, Go and PHP keep their complete tooling selections together:

```lua
languages = {
    go = {
        filetypes = { "go" },
        highlighting = { "go" },
        lsp = { { "gopls" } },
        formatters = { "goimports", "gofumpt" },
        linters = { "golangcilint" },
        dap = {
            { "delve", adapter = { "delve", go_debug.adapter }, configurations = go_debug.configurations },
        },
    },
    php = {
        filetypes = { "php" },
        highlighting = { "php" },
        lsp = { { "intelephense", php.intelephense } },
        formatters = { "easy-coding-standard" },
        linters = { "phpstan" },
        format_on_save = { timeout_ms = 2000 },
        dap = {
            { "php-debug-adapter", adapter = { "php", php_debug.adapter }, configurations = php_debug.configurations },
        },
    },
},
```

Omit settings a profile does not need instead of adding empty placeholders.
Formatter and linter lists are optional; per-profile save overrides preserve
the global LSP fallback setting.

Detailed LSP/DAP settings remain in deferred config functions under
`configs/development/lsp/` and `configs/development/dap/`. The registry associates
their results with server/adapter names using references such as
`{ "vtsls", vue.vtsls }` and `{ "vue_ls", vue.vue_ls }`. Declare each LSP server
once: `javascript.lsp` owns vtsls, including its Vue bridge; `vue.lsp` owns Vue LS.
LSP filetype coverage comes from the server configuration, not from the profile's
`filetypes`. Omitting a tuple's second item keeps the server defaults. Overrides
are applied before enabling servers; `:LspReindex` uses the same profile tuples
to identify managed clients.

A profile's `dap` is a list because it can register several adapters. The
JavaScript profile registers both `pwa-node` and `pwa-chrome`. Its Node record
inherits the profile's JS/TS filetypes and provides Node and browser launch/attach
choices. Its browser record overrides `filetypes` with JSX/TSX, Vue and HTML, where
only browser launch/attach choices apply. Records without an override inherit
their profile's filetypes. DAP configurations are copied separately per filetype
to isolate runtime changes.

Mason collects server, formatter, linter and debugger packages from all profiles,
deduplicates shared packages such as `js-debug-adapter`, and sorts the installation
list. The Lua DAP record has no positional package: OSV is a lazy.nvim dependency,
not a Mason tool. Lint triggers stay in `configs/development/lint.lua`; plugin
loading rules, UI settings and setup code stay in `plugins/` and `configs/`.


### Formatting and diagnostics

| Language/filetypes | Formatting | Diagnostics |
| --- | --- | --- |
| Lua | StyLua | Lua LS + luacheck (Neovim's `vim` global is allowed) |
| Vimscript | LSP fallback if supported by the server | Vim LS + Vint |
| JS/TS, JSX/TSX, Vue | prettierd | vtsls/Vue LS + eslint_d |
| HTML | prettierd | HTMLHint (the HTML language server provides completion/navigation, not general HTML linting) |
| CSS/SCSS/LESS | prettierd | CSS language server |
| JSON/JSONC | prettierd | JSON LS (including schema validation) |
| Python | Black | Pyright + Ruff |
| Go | goimports, then gofumpt | gopls + golangci-lint |
| PHP | Easy Coding Standard | Intelephense + PHPStan |
| Prisma | Prisma language-server formatting | Prisma language-server validation |

Formatting runs on save and through the format mapping. Both use LSP formatting
only when no configured external formatter is available. Saves have a 500 ms
formatting budget by default; PHP gets 2000 ms because cold ECS formatting of
larger files can exceed the default. Vimdoc has syntax highlighting, not a runtime
debugger or a standalone formatter/linter.
Automatic linting runs on `BufWritePost`; `:Lint` runs the same linters manually.
Linters resolve roots from the current file and their own project markers, so
ESLint, Ruff and Go can select different roots inside a monorepo. Without a marker,
a named file uses its own directory, not Neovim's cwd; unnamed/non-file buffers
fall back to cwd. Resolved paths are canonicalized to avoid duplicate symlink roots.

Keep project rules in the project: ESLint config and the required TypeScript/Vue
parsers/plugins, `ecs.php`, PHPStan configuration, `.htmlhintrc` overrides, and a
golangci-lint configuration compatible with its installed major version. Mason installs executables, not
application dependencies or lint policies. JSONC is validated by JSON LS, not a
strict JSON CLI linter. There is no duplicate TypeScript LSP client: vtsls handles
JS/TS and the Vue TypeScript bridge.

### Debugging

| Language | Adapter | Configurations |
| --- | --- | --- |
| JS/TS | `pwa-node` / `pwa-chrome` | Node launch/process attach; browser launch/port attach |
| JSX/TSX, Vue, HTML | `pwa-chrome` | Browser launch or attach on port 9222 |
| Python | debugpy | Current-file launch or attach on port 5678 |
| Go | Delve | Current package, package tests, or local-process attach |
| PHP | vscode-php-debug + Xdebug | Listen on port 9003 or launch the current CLI file |
| Neovim Lua | one-small-step-for-vimkind | Attach to another Neovim instance on port 8086 |

Node/browser, Python, Go and PHP CLI configurations derive their working directory
from the current file's project markers, not the directory Neovim was launched in.
Go launches/tests build the selected file's package while both Delve and the target
use the module/workspace root. Python's local attach mappings default to that same
project root; customize both mappings when debugging a remote filesystem.

- TypeScript Node launches ask for the compiled JavaScript entry point. The last
  non-empty choice is the editable default for that project for this Neovim session;
  it is not persisted to disk. Build with source maps (`sourceMap: true`); adapters
  wait for maps so startup breakpoints bind before the mapped code executes.
  Output/source-map lookup uses the selected file's project root.
- Browser launches ask for the running application's URL (default port 5173) and
  remember an editable default separately for each project during the session.
  Browser source mapping uses that project's `webRoot`. Browser attach requires an
  existing browser started with `--remote-debugging-port=9222`; development builds
  need source maps for TS/Vue. Serve generated source-map files alongside compiled
  scripts so the adapter can fetch them over HTTP.
- Python launch uses `:VenvSelect`, then `VIRTUAL_ENV`, then a project environment
  matching `languages.python.venv`, then `python3`. Optional selector plugin settings
  belong in `languages.python.tools.venv_selector`; no settings block is needed for
  defaults. Remote Python attach uses `config.connect` and `pathMappings`; start
  the target with debugpy listening on the matching port.
- Go requires a working toolchain and platform debugger permissions. On macOS,
  authorize the developer tools when requested; `DevToolsSecurity -status` shows
  whether developer mode is enabled.
- PHP requires Xdebug enabled in the PHP executable used by the target. For web
  requests, enable `xdebug.mode=debug`, configure the client host/port, and use the
  listen configuration. Set `pathMappings` when remote paths differ from local paths.
- Lua debugging uses two Neovim instances. In the target, load the dependency with
  `:lua require("lazy").load({plugins={"one-small-step-for-vimkind"}})`, then run
  `:lua require("osv").launch({port=8086})`. In the other instance choose the Lua
  attach configuration, set breakpoints, then execute the target Lua code. OSV
  supports locals and hover/repl evaluation, but not DAP watch evaluation.
- Vimscript uses Neovim's built-in `:debug`, not a DAP adapter.
- CSS, JSON, Prisma and Vimdoc are not executable runtimes and have no artificial
  debugger adapters.


### Configuration conventions

- `chadrc.lua` owns the NvChad theme and UI settings. `configs/lazy.lua` owns
  plugin-manager defaults, its own window icons and runtime-path exclusions;
  its install-time colorscheme preference reads `chadrc.base46.theme` rather
  than repeating the theme name. The two `ui` tables configure different UIs.
- `lua/plugins/<category>/` contains lazy.nvim specifications: plugin identity,
  loading triggers, dependencies, keys, and deferred config calls. The root
  `plugins/init.lua` declares category imports; it performs no plugin setup.
- Every module in `lua/configs/` exports a function. Importing it must not run
  plugin setup or compute settings; the function executes only when called.
- Keep shared project discovery in `project_root.lua`; linter-specific argument
  and cwd adaptation belongs in `configs/development/linters/project_cwd.lua`.
- A plugin with no custom settings can use `opts = {}` directly in its spec.
  This retains default `setup()` and inherited option merging without an empty
  config wrapper, as with the Treesitter manager and TypeScript error translator.
- An options function creates its overrides and merges them with the inherited
  options. Called without arguments, it returns its own settings:

  ```lua
  return function(opts)
      local options = { map_bs = false }
      return opts and vim.tbl_deep_extend("force", opts, options) or options
  end
  ```

- Plugin specs call these functions through a deferred adapter. lazy.nvim passes
  the plugin as its first argument, so forward only the second argument (`opts`):

  ```lua
  return {
      "windwp/nvim-autopairs",
      opts = function(_, opts)
          return require("configs.editing.autopairs")(opts)
      end,
  }
  ```

- Configs that register adapters, listeners, autocommands, or other imperative
  behavior use the same function export and invocation, but run in the `config`
  hook instead of `opts`:

  ```lua
  config = function(_, opts)
      return require("configs.development.lsp")(opts)
  end,
  ```

- Keep `opts` for settings and `config` for initialization. `opts` preserves
  inherited options; a custom `config` replaces the inherited callback, so call
  any required base initialization explicitly. Specify `main` when a plugin's
  Lua module name is ambiguous. Bootstrap and language-registry settings use
  the same function contract, for example `require("configs.lazy")()`.
- `core/` and `features/` export `M.setup()` and are initialized explicitly in
  `init.lua`; mappings remain scheduled after startup.

### Tooling regression checks

From the repository root, run:

```sh
nvim -n --headless -u NONE -l tests/tooling.lua
```

The isolated checks exercise file-derived and tool-specific roots, standalone-file
fallbacks, dynamic Node cwd/output/source-map scopes, browser web roots and Python
attach mappings while switching projects under an unrelated editor cwd. They also
cover editable per-project DAP defaults, empty input and canonical symlink identity,
without requiring external language tools.

## Plugin List

The plugins below are grouped by their main purpose to make it easier to see what each one adds to the configuration.

### Libraries & dependencies
- [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim) – common Lua functions
- [nvim-neotest/nvim-nio](https://github.com/nvim-neotest/nvim-nio) – async IO helpers
- [nvzone/volt](https://github.com/nvzone/volt) – UI framework
- [rcarriga/nvim-notify](https://github.com/rcarriga/nvim-notify) – notification UI

### Interface & appearance
- [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) – file icons
- [mawkler/modicator.nvim](https://github.com/mawkler/modicator.nvim) – line-number color by mode
- [cpea2506/relative-toggle.nvim](https://github.com/cpea2506/relative-toggle.nvim) – smart relative line numbers
- [mawkler/hml.nvim](https://github.com/mawkler/hml.nvim) – H/M/L line markers
- [briangwaltney/paren-hint.nvim](https://github.com/briangwaltney/paren-hint.nvim) – show the opening line of the surrounding parenthesis
- [hiphish/rainbow-delimiters.nvim](https://github.com/hiphish/rainbow-delimiters.nvim) – rainbow brackets
- [m-demare/hlargs.nvim](https://github.com/m-demare/hlargs.nvim) – highlight function arguments
- [Fildo7525/pretty_hover](https://github.com/Fildo7525/pretty_hover) – nicer LSP hover
- [hedyhli/outline.nvim](https://github.com/hedyhli/outline.nvim) – symbol outline
- [j-hui/fidget.nvim](https://github.com/j-hui/fidget.nvim) – LSP progress UI

### Navigation & search
- [nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) – file explorer
- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) – powerful search
- [ibhagwan/fzf-lua](https://github.com/ibhagwan/fzf-lua) – fzf-based finder
- [folke/flash.nvim](https://github.com/folke/flash.nvim) – quick jump navigation
- [XXiaoA/atone.nvim](https://github.com/XXiaoA/atone.nvim) – undo-tree viewer with diff previews
- [LintaoAmons/cd-project.nvim](https://github.com/LintaoAmons/cd-project.nvim) – switch project directories

### Editing
- [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs) – automatic bracket and quote pairs
- [windwp/nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) – auto close/rename HTML & JSX tags
- [qwavies/smart-backspace.nvim](https://github.com/qwavies/smart-backspace.nvim) – context-aware backspace
- [sontungexpt/bim.nvim](https://github.com/sontungexpt/bim.nvim) – instant insert-mode mappings without the `timeoutlen` wait

### LSP, completion & AI
- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) – configure built-in LSP
- [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) – completion engine
- [Exafunction/windsurf.nvim](https://github.com/Exafunction/windsurf.nvim) – Codeium/Windsurf, the only AI completion provider
- [SergioRibera/cmp-dotenv](https://github.com/SergioRibera/cmp-dotenv) – `.env` completion source
- [sontungexpt/better-diagnostic-virtual-text](https://github.com/sontungexpt/better-diagnostic-virtual-text) – inline diagnostics
- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) – Treesitter highlighting

### Formatting & tooling
- [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim) – formatter runner
- [mfussenegger/nvim-lint](https://github.com/mfussenegger/nvim-lint) – linter runner
- [mason-org/mason.nvim](https://github.com/mason-org/mason.nvim) – LSP/DAP/linter/formatter package manager
- [WhoIsSethDaniel/mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) – auto-install tools from the language registry

### Language support
- [dmmulroy/ts-error-translator.nvim](https://github.com/dmmulroy/ts-error-translator.nvim) – clearer TypeScript errors
- [yelog/i18n.nvim](https://github.com/yelog/i18n.nvim) – i18n translation hints
- [Kenzo-Wada/boundary.nvim](https://github.com/Kenzo-Wada/boundary.nvim) – mark React client-component usages
- [linux-cultist/venv-selector.nvim](https://github.com/linux-cultist/venv-selector.nvim) – Python virtualenv selector

### Debugging
- [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap) – debug adapter protocol client
- [rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) – UI for nvim-dap
- [jbyuki/one-small-step-for-vimkind](https://github.com/jbyuki/one-small-step-for-vimkind) – Lua debugger for a separate Neovim instance

### Utilities
- [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim) – highlight TODOs
- [folke/trouble.nvim](https://github.com/folke/trouble.nvim) – diagnostics list
- [nvzone/floaterm](https://github.com/nvzone/floaterm) – floating terminal
- [ph1losof/ecolog.nvim](https://github.com/ph1losof/ecolog.nvim) – environment variable manager
- [inhesrom/remote-ssh.nvim](https://github.com/inhesrom/remote-ssh.nvim) – edit remote files over SSH with LSP *(with [telescope-remote-buffer](https://github.com/inhesrom/telescope-remote-buffer))*
- [wakatime/vim-wakatime](https://github.com/wakatime/vim-wakatime) – coding stats

## Credits

Configuration built on [NvChad](https://nvchad.com) by [Siduck](https://github.com/siduck) and the NvChad team.
