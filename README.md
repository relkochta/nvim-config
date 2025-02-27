# relkochta/nvim-config

![My Neovim configuration, showing rust-analyzer integration](/screenshot.png?raw=true)

**Note:** the main home for this repository is on [Gitea](https://git.relkochta.com/relkochta/nvim-config).

This repository contains my configuration for [Neovim](https://neovim.io/).
It's written in Lua and uses the [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager along with [lsp-zero.nvim](https://github.com/VonHeikemen/lsp-zero.nvim) for language server support.

Requirements:

- Neovim 0.8.0
- Git
- A C compiler (such as `gcc` or `clang`) for compiling Treesitter parsers
- `ripgrep` for fuzzy search
- Any desired language servers (`rust-analyzer`, `clangd`, `bash-language-server`, etc)
