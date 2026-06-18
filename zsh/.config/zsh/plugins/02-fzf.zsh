local fzf_ignore='--no-ignore --hidden --follow --exclude .git --exclude .venv --exclude __pycache__ --exclude node_modules --exclude .mypy_cache --exclude .pytest_cache --exclude .ruff_cache --exclude .tox --exclude .eggs --exclude .DS_Store'

source <(fzf --zsh)

# --color=16 uses the 16 ANSI colors from the terminal palette (Ghostty's
# GitHub theme) instead of fzf's fixed default scheme — follows light/dark.
export FZF_DEFAULT_OPTS="--color=16"
export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix ${fzf_ignore}"
export FZF_CTRL_T_COMMAND="fd --type f --strip-cwd-prefix ${fzf_ignore}"

# **<TAB> trigger completion
_fzf_compgen_path() { fd ${=fzf_ignore} . "$1" }
_fzf_compgen_dir() { fd --type d ${=fzf_ignore} . "$1" }

alias fz='fzf --preview="bat --color=always {}"'
