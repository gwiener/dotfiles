auto_activate_venv() {
  local dir="$PWD"
  # Walk up to find the nearest .venv
  while [[ "$dir" != "/" ]]; do
    if [[ -d "$dir/.venv" ]]; then
      if [[ "$VIRTUAL_ENV" != "$dir/.venv" ]]; then
        # New or different venv — activate it
        [[ -n "$VIRTUAL_ENV" ]] && path=(${path:#$VIRTUAL_ENV/bin})
        export VIRTUAL_ENV="$dir/.venv"
        path=("$VIRTUAL_ENV/bin" $path)
      fi
      return
    fi
    dir="${dir:h}"
  done
  # No .venv found anywhere up the tree — deactivate
  if [[ -n "$VIRTUAL_ENV" ]]; then
    path=(${path:#$VIRTUAL_ENV/bin})
    unset VIRTUAL_ENV
  fi
}
chpwd_functions+=(auto_activate_venv)
