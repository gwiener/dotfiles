# Python venv indicator
_py_venv() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    echo "($(basename "$VIRTUAL_ENV")) "
  fi
}

_ws_pwd() {
  if [[ "$PWD" == "$WORKSPACE_ROOT"* ]]; then
    local rel="${PWD#$WORKSPACE_ROOT}"
    [[ -z "$rel" ]] && rel="."
    echo "${rel#/}"
  else
    # fallback outside workspace
    echo "${PWD/#$HOME/~}"
  fi
}

if [[ "$TERM_PROGRAM" == "vscode" ]]; then
  setopt PROMPT_SUBST
  PROMPT='$(_py_venv)$(_ws_pwd) ❯ '
else
  eval "$(starship init zsh)"
fi
