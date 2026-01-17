# Neovim Configuration

My personal Neovim configuration with LSP support, intelligent completion, file navigation, and more.

## 📦 Installation

Clone this repository into your `~/.config` folder:

```bash
git clone https://github.com/Dor256/neovim-config.git ~/.config/nvim
```

After cloning, open Neovim and the plugins will automatically install via [lazy.nvim](https://github.com/folke/lazy.nvim).

## 🎨 Theme

- **[TokyoNight](https://github.com/folke/tokyonight.nvim)** - A dark, modern colorscheme with the "storm" variant
  - Non-italic keywords for cleaner code appearance
  - Custom Git signs and Neo-tree highlight colors

## 🔌 Plugins

### Core Functionality

#### [lazy.nvim](https://github.com/folke/lazy.nvim)
Plugin manager that provides fast startup times and lazy-loading capabilities.

#### [Mason](https://github.com/williamboman/mason.nvim) + [LSP Config](https://github.com/neovim/nvim-lspconfig)
- Automatic installation and management of LSP servers
- Pre-configured language servers:
  - `lua_ls` - Lua
  - `ts_ls` - TypeScript/JavaScript
  - `pyright` - Python
  - `eslint` - ESLint linting
  - `hls` - Haskell Language Server
  - `gopls` - Go

### Code Intelligence

#### [Blink.cmp](https://github.com/saghen/blink.cmp)
Fast, feature-rich autocompletion plugin with:
- LSP-based completions
- Snippet support (via [friendly-snippets](https://github.com/rafamadriz/friendly-snippets))
- Buffer and path completions
- Super-tab keybindings (Tab to accept/navigate)
- Signature help for function parameters

#### [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
Advanced syntax highlighting and code understanding with support for:
- JavaScript, TypeScript, TSX
- Python, Lua, C, C++
- Haskell, Scala, Java
- HTML, JSON, YAML, Proto
- And more...

### File Navigation

#### [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim)
Modern file explorer with:
- Git integration
- Dotfile visibility
- 30-character width left sidebar
- Shows all files (including git-ignored ones)

#### [Telescope](https://github.com/nvim-telescope/telescope.nvim)
Fuzzy finder for files, text, and more with:
- File search and live grep
- LSP integration (implementations, references)
- Git status search

### Git Integration

#### [Gitsigns](https://github.com/lewis6991/gitsigns.nvim)
Shows git changes in the sign column with inline blame and hunk navigation.

### UI Enhancements

#### [Lualine](https://github.com/nvim-lualine/lualine.nvim)
Clean statusline with:
- TokyoNight theme integration
- Global status (single statusline)
- LSP status indicator
- Minimal separators for a clean look

#### [Bufferline](https://github.com/akinsho/bufferline.nvim)
Tab-like buffer display at the top with:
- Shows open buffers as tabs
- Neo-tree offset showing current directory name
- Clean design without close icons

#### [Trouble](https://github.com/folke/trouble.nvim)
Pretty list for diagnostics, references, and more. See keymaps below for usage.

### Utilities

#### [ToggleTerm](https://github.com/akinsho/toggleterm.nvim)
Integrated terminal that can be toggled with `<C-j>`.

#### [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
Automatic bracket, quote, and tag pairing.

#### [Mini.bufremove](https://github.com/echasnovski/mini.bufremove)
Intelligently close buffers without disrupting window layout.

#### [Which-key](https://github.com/folke/which-key.nvim)
Displays available keybindings in a popup window to help discover and remember keyboard shortcuts.

## ⌨️ Keymaps

Leader key is set to `<Space>`.

### General

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>e` | Normal | Show diagnostic error messages in floating window |
| `<leader>q` | Normal | Open diagnostic list |
| `<leader>r` | Normal | Format/indent entire file without moving cursor |
| `<leader>s` | Normal | Replace word under cursor everywhere in file |
| `<leader>/` | Normal | Toggle comment on current line |
| `<leader>/` | Visual | Toggle comment on selected lines |
| `<leader>?` | Normal | Show available keybindings for current buffer |

### LSP (Language Server)

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>K` | Normal | LSP hover documentation |
| `<leader>gd` | Normal | Jump to definition |
| `<leader>gD` | Normal | Jump to declaration |
| `<leader>gi` | Normal | Jump to implementation |
| `<leader>gt` | Normal | Jump to type definition |
| `<leader>gr` | Normal | Show references (using Telescope) |
| `<leader>ca` | Normal | LSP code action |

### File Navigation

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>o` | Normal | Toggle focus between Neo-tree and editor |
| `<leader>ff` | Normal | Search for files |
| `<leader>fg` | Normal | Search for text/grep in files |
| `<leader>fc` | Normal | Search git conflicts/status |

### Buffer Management

| Keymap | Mode | Description |
|--------|------|-------------|
| `<Tab>` | Normal | Next buffer |
| `<Shift-Tab>` | Normal | Previous buffer |
| `<leader>w` | Normal | Close current buffer and move to next |

### Text Editing

| Keymap | Mode | Description |
|--------|------|-------------|
| `J` | Visual | Move selected text down |
| `K` | Visual | Move selected text up |
| `<leader>{` | Visual | Wrap selected text in `{}` |
| `<leader>(` | Visual | Wrap selected text in `()` |
| `<leader>[` | Visual | Wrap selected text in `[]` |
| `<leader><` | Visual | Wrap selected text in `<>` |
| `<leader>"` | Visual | Wrap selected text in `""` |
| `<leader>'` | Visual | Wrap selected text in `''` |
| `<S-Tab>` | Insert | Outdent line |

### Terminal

| Keymap | Mode | Description |
|--------|------|-------------|
| `<C-j>` | Normal/Insert/Terminal | Toggle integrated terminal |
| `<C-n>` | Terminal | Exit terminal mode to normal mode (for browsing output) |

### Trouble (Diagnostics)

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>xx` | Normal | Toggle diagnostics panel |
| `<leader>xX` | Normal | Toggle buffer diagnostics |
| `<leader>cs` | Normal | Toggle symbols panel |
| `<leader>cl` | Normal | Toggle LSP definitions/references |
| `<leader>xL` | Normal | Toggle location list |
| `<leader>xQ` | Normal | Toggle quickfix list |

## ⚙️ Settings

### Indentation
- **Tab size**: 4 spaces
- **Expand tabs**: Yes (spaces, not tabs)
- **Smart indentation**: Enabled
- **Show whitespace**: Enabled (trailing spaces, extends/precedes indicators)

### Line Numbers
- **Absolute line numbers**: Enabled
- **Relative line numbers**: Enabled
- **Cursor line highlight**: Enabled

### Files & Backup
- **Swap file**: Disabled
- **Backup file**: Disabled
- **Undo file**: Enabled (stored in `~/.config/nvim/undodir`)
- **Clipboard**: Integrated with system clipboard

### Search
- **Highlight search**: Disabled (cleaner after search)
- **Incremental search**: Enabled
- **Ignore case**: Enabled (smart case-sensitive when uppercase letters are used)

### UI
- **Sign column**: Always visible (1 column)
- **Scroll offset**: 8 lines (keeps cursor away from edges)
- **Show mode**: Disabled (shown in statusline instead)
- **Global statusline**: Enabled (single statusline for all windows)
- **True colors**: Enabled
- **Mouse support**: Enabled
- **Window borders**: Fancy Unicode box-drawing characters

### Auto-features

#### Autosave
Files are automatically saved when:
- Leaving insert mode
- Text is changed (while in normal mode)

#### Diagnostic Floats
- Diagnostic messages appear automatically after 500ms of cursor hold
- Only warnings and errors shown in virtual text
- Severity sorting enabled (most severe diagnostic highlighted)

#### ESLint Auto-fix
- ESLint errors are automatically fixed on save for JavaScript/TypeScript files

#### Other
- Automatic comment continuation disabled (no auto-inserting comment leaders on new lines)

## 🎯 Features

- **Fast startup** with lazy-loaded plugins
- **Intelligent code completion** with LSP and Treesitter
- **Modern UI** with clean statusline and buffer tabs
- **Git integration** with inline change indicators
- **Auto-save** for peace of mind
- **Persistent undo** across sessions
- **Integrated terminal** for quick command execution
- **Diagnostic floats** for instant error feedback

## 📝 Requirements

- Neovim >= 0.11.0
- Git
- A Nerd Font (for icons)
- Node.js (for some LSP servers)
- Python 3 (for Python LSP)

## 🛠️ Customization

This configuration is structured for easy customization:

```
~/.config/nvim/
├── init.lua              # Main entry point
├── lua/
│   ├── config/
│   │   ├── init.lua      # Core configuration and leader key
│   │   ├── lazy.lua      # Plugin manager setup
│   │   ├── keymaps.lua   # Keymaps
│   │   └── settings.lua  # Vim options
│   └── plugins/          # Individual plugin configurations
│       ├── autopair.lua
│       ├── blink.lua
│       ├── bufferline.lua
│       ├── bufremove.lua
│       ├── colors.lua
│       ├── gitsigns.lua
│       ├── lualine.lua
│       ├── mason.lua
│       ├── neo-tree.lua
│       ├── telescope.lua
│       ├── terminal.lua
│       ├── treesitter.lua
│       ├── trouble.lua
│       └── which-key.lua
```

To add new plugins, create a new file in `lua/plugins/` that returns a lazy.nvim plugin spec.

## 📄 License

Feel free to use and modify this configuration as you see fit!
