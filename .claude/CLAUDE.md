# DOTS — Dotfiles repo

macOS (Apple Silicon) dotfiles managed with GNU Stow. Each top-level folder is
a stow package that maps to `$HOME` — run `stow <package>` from the repo root
to symlink. Do not run stow — the user does that manually.

## Environment
- Package manager: Homebrew (`/opt/homebrew/`)
- Terminal: Ghostty
- Shell: ZSH with vi mode
- Font: JetBrains Mono Nerd Font. Any font configuration should use a Nerd Font.

## Convention
- Config files go under `<package>/.config/<tool>/` (targeting `~/.config/`)
- Non-config files mirror their home-dir path (e.g., `.local/share/`)
- All tools must support both light and dark color themes, following macOS
  system appearance. Prefer native appearance detection (e.g., Ghostty handles
  this itself). The `dark()`/`appear()` shell functions in prompt.zsh are a
  last resort for tools that lack native appearance awareness.
- ZSH uses a plugin-based setup: `~/.config/zsh/plugins/*.zsh`
  loaded alphabetically by a thin `~/.zshrc` loader.
  `01-core.zsh` loads first (compinit, PATH), rest are topic-based.
- ZSH edits go into the git-controlled plugin files, not `~/.zshrc`,
  unless they contain secrets.

## Packages
- ghostty — Ghostty terminal config
- nvim — Neovim config (Lazy.nvim)
- raycast — Raycast scripts (stowed to ~/.local/share/raycast/)
- starship — Starship prompt config
- zsh — ZSH plugins (completions, aliases, tool integrations)
