source <(fzf --zsh)
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --exclude .git,node_modules,.venv'
alias fz='fzf --preview="bat --color=always {}"'
