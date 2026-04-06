# Life on the Terminal

Personal macOS dotfiles — Ghostty, Neovim, ZSH, Starship, and friends.

Managed with [GNU Stow](https://www.gnu.org/software/stow/). Each folder is a
stow package mirroring the home directory structure. Install any package with:

    cd ~/DOTS && stow <package>

## Packages

| Package    | What                              |
|------------|-----------------------------------|
| ghostty    | Ghostty terminal configuration    |
| nvim       | Neovim config (Lazy.nvim)         |
| raycast    | Raycast shared scripts            |
| starship   | Starship prompt theme             |
| task       | TaskWarrior configuration & hooks |
| zsh        | ZSH plugin-based shell setup      |

## TaskWarrior domain tags

Projects are grouped into domains (e.g. `+work`, `+hack`) via tags. When a task
is added to or moved into a project, hooks automatically apply the domain tag
that all other tasks in that project share. This keeps projects cleanly
separated into domains without manually tagging every task. Domain tags are
configured in `task/.task/hooks/domains.conf`.
