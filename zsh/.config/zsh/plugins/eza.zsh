local eza_ignore='.git|.venv|__pycache__|node_modules|.mypy_cache|.pytest_cache|.ruff_cache|.tox|.eggs|*.egg-info|.DS_Store'

alias l="eza -I '${eza_ignore}'"
alias ll="eza -lF --icons --git -I '${eza_ignore}'"
alias lt="eza -TF -L 4 --icons --follow-symlinks -I '${eza_ignore}'"
alias la="eza -lF -a --icons --git -I '${eza_ignore}'"
alias lg="eza -GF --icons --git -I '${eza_ignore}'"
