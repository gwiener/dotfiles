autoload -Uz compinit
compinit

PATH="$HOME/.local/bin:$PATH"

export EDITOR=nvim
alias v=nvim

# Capture initial directory as workspace root (VS Code)
if [[ -z "$WORKSPACE_ROOT" ]]; then
  export WORKSPACE_ROOT="$PWD"
fi

dark() {
  defaults read -g AppleInterfaceStyle 2>/dev/null | grep -q Dark
}

appear() {
  $(dark) && echo "dark" || echo "light"
}

