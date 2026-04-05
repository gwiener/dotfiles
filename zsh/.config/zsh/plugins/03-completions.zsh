# Show dotfiles in completion
_comp_options+=(globdots)

# Hide junk folders unless explicitly typed (_ignored retries without filter)
zstyle ':completion:*' ignored-patterns '.git' '.venv' '__pycache__' 'node_modules' '.mypy_cache' '.pytest_cache' '.ruff_cache' '.tox' '.eggs' '*.egg-info' '.DS_Store'
zstyle ':completion:*' completer _extensions _complete _ignored

# fzf-tab: override shell completions with a nice pulldown
source "/opt/homebrew/opt/fzf-tab/share/fzf-tab/fzf-tab.zsh"

eval "$(uv generate-shell-completion zsh)"
